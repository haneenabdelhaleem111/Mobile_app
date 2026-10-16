import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart_models.dart';

class WooCartException implements Exception {
  const WooCartException(this.message, {this.statusCode, this.apiCode});

  final String message;
  final int? statusCode;
  final String? apiCode;

  @override
  String toString() => message;
}

/// A Store API cart client. Its Cart-Token is held in memory only and is never
/// logged or written to persistent storage.
class WooCommerceCartService {
  WooCommerceCartService({
    http.Client? client,
    String? baseUrl,
    Duration timeout = const Duration(seconds: 20),
  })  : _client = client ?? http.Client(),
        _baseUrl = _normalizeBaseUrl(
          baseUrl ??
              const String.fromEnvironment(
                'WOOCOMMERCE_BASE_URL',
                defaultValue: 'https://el-emshaty-pharmacy.com',
              ),
          devProxyEnabled: const bool.fromEnvironment(
            'ENABLE_WOOCOMMERCE_DEV_PROXY',
          ),
        ),
        _timeout = timeout;

  static final WooCommerceCartService instance = WooCommerceCartService();
  static const String _devProxyHost = '127.0.0.1';
  static const int _devProxyPort = 8787;
  static const String _cartPath = '/wp-json/wc/store/v1/cart';

  final http.Client _client;
  final String _baseUrl;
  final Duration _timeout;
  String? _cartToken;
  String? _nonce;
  Future<void> _requestQueue = Future<void>.value();

  /// The token is intentionally not exposed; callers use cart responses only.
  bool get hasCartToken => _cartToken?.isNotEmpty == true;

  /// Sends a Store API checkout request through this cart session. Keeping
  /// checkout transport here ensures it shares the cart's token, nonce, client,
  /// base URL, and request queue. The raw session headers are never returned.
  Future<Map<String, dynamic>> requestCheckout({
    required String method,
    Map<String, String> query = const {},
    Map<String, Object?>? body,
  }) {
    const path = '/wp-json/wc/store/v1/checkout';
    if (!const {'GET', 'PUT', 'POST'}.contains(method) ||
        (method == 'GET' && (body != null || query.isNotEmpty)) ||
        (method != 'GET' && body == null) ||
        query.keys.any((key) => key != '__experimental_calc_totals') ||
        (query['__experimental_calc_totals'] != null &&
            !const {'true', 'false'}
                .contains(query['__experimental_calc_totals']))) {
      throw const WooCartException('Invalid checkout request.');
    }
    return _enqueue(() => _sendCheckoutRequest(
          path,
          method,
          query: query,
          body: body,
        ));
  }

  Future<WooCart> getCart() =>
      _enqueue(() => _sendCartRequest('GET', _cartPath));

  Future<WooCart> addItem({required int productId, int quantity = 1}) {
    if (productId <= 0 || quantity <= 0) {
      throw const WooCartException(
          'A valid product and quantity are required.');
    }
    return _enqueue(
      () => _sendCartRequest(
        'POST',
        '$_cartPath/add-item',
        body: {'id': productId, 'quantity': quantity},
      ),
    );
  }

  Future<WooCart> updateItem({required String key, required int quantity}) {
    if (key.trim().isEmpty || quantity <= 0) {
      throw const WooCartException(
          'A valid cart item key and quantity are required.');
    }
    return _enqueue(
      () => _sendCartRequest(
        'POST',
        '$_cartPath/update-item',
        body: {'key': key, 'quantity': quantity},
      ),
    );
  }

  Future<WooCart> removeItem({required String key}) {
    if (key.trim().isEmpty) {
      throw const WooCartException('A valid cart item key is required.');
    }
    return _enqueue(
      () => _sendCartRequest(
        'POST',
        '$_cartPath/remove-item',
        body: {'key': key},
      ),
    );
  }

  /// Clears only this service instance's in-memory token. It does not send a
  /// request or modify the server cart.
  void clearSession() {
    _cartToken = null;
    _nonce = null;
  }

  Future<T> _enqueue<T>(Future<T> Function() operation) {
    final result = _requestQueue.then((_) => operation());
    // Keep the queue usable after a request fails; return the original failure
    // to the caller without logging or retaining its response data.
    _requestQueue = result.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return result;
  }

  Future<WooCart> _sendCartRequest(
    String method,
    String path, {
    Map<String, Object>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$path');
    if (!_isAllowedRequestUri(uri)) {
      throw const WooCartException('The cart service requires HTTPS.');
    }

    final request = http.Request(method, uri)
      ..headers['Accept'] = 'application/json';
    final token = _cartToken;
    final nonce = _nonce;
    if (token != null && token.isNotEmpty) {
      request.headers['Cart-Token'] = token;
    } else if (nonce != null && nonce.isNotEmpty) {
      request.headers['Nonce'] = nonce;
    }
    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }

    try {
      final streamed = await _client.send(request).timeout(_timeout);
      final response =
          await http.Response.fromStream(streamed).timeout(_timeout);
      _captureSessionHeaders(response.headers);
      final isJson = (response.headers['content-type'] ?? '')
          .toLowerCase()
          .contains('application/json');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final apiCode = isJson ? _readApiErrorCode(response.bodyBytes) : null;
        throw WooCartException(
          'The cart request failed (${response.statusCode}).',
          statusCode: response.statusCode,
          apiCode: apiCode,
        );
      }
      if (!isJson) {
        throw WooCartException(
          'The cart endpoint did not return application/json.',
          statusCode: response.statusCode,
        );
      }

      dynamic decoded;
      try {
        decoded = jsonDecode(utf8.decode(response.bodyBytes));
      } on FormatException {
        throw WooCartException(
          'The cart endpoint returned malformed JSON.',
          statusCode: response.statusCode,
        );
      }
      if (decoded is! Map) {
        throw WooCartException(
          'The cart response was not a JSON object.',
          statusCode: response.statusCode,
        );
      }
      return WooCart.fromJson(Map<String, dynamic>.from(decoded));
    } on TimeoutException {
      throw const WooCartException('The cart request timed out.');
    } on http.ClientException {
      throw const WooCartException('Could not reach the WooCommerce cart.');
    } on WooCartException {
      rethrow;
    } catch (_) {
      throw const WooCartException(
          'Could not process the WooCommerce cart response.');
    }
  }

  Future<Map<String, dynamic>> _sendCheckoutRequest(
    String path,
    String method, {
    required Map<String, String> query,
    required Map<String, Object?>? body,
  }) async {
    final checkoutUri = Uri.parse('$_baseUrl$path');
    final uri = query.isEmpty
        ? checkoutUri
        : checkoutUri.replace(queryParameters: query);
    if (!_isAllowedRequestUri(uri)) {
      throw const WooCartException('The checkout service requires HTTPS.');
    }
    final request = http.Request(method, uri)
      ..headers['Accept'] = 'application/json';
    final token = _cartToken;
    final nonce = _nonce;
    if (token != null && token.isNotEmpty) {
      request.headers['Cart-Token'] = token;
    } else if (nonce != null && nonce.isNotEmpty) {
      request.headers['Nonce'] = nonce;
    }
    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }
    try {
      final streamed = await _client.send(request).timeout(_timeout);
      final response =
          await http.Response.fromStream(streamed).timeout(_timeout);
      _captureSessionHeaders(response.headers);
      final isJson = (response.headers['content-type'] ?? '')
          .toLowerCase()
          .contains('application/json');
      if (response.statusCode < 200 || response.statusCode >= 300) {
        final apiCode = isJson ? _readApiErrorCode(response.bodyBytes) : null;
        throw WooCartException(
          'The checkout request failed (${response.statusCode}).',
          statusCode: response.statusCode,
          apiCode: apiCode,
        );
      }
      if (!isJson) {
        throw WooCartException(
          'The checkout endpoint did not return application/json.',
          statusCode: response.statusCode,
        );
      }
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map) {
        throw WooCartException(
          'The checkout response was not a JSON object.',
          statusCode: response.statusCode,
        );
      }
      return Map<String, dynamic>.from(decoded);
    } on TimeoutException {
      throw const WooCartException('The checkout request timed out.');
    } on http.ClientException {
      throw const WooCartException('Could not reach WooCommerce checkout.');
    } on WooCartException {
      rethrow;
    } on FormatException {
      throw const WooCartException(
        'The checkout endpoint returned malformed JSON.',
      );
    } catch (_) {
      throw const WooCartException(
        'Could not process the WooCommerce checkout response.',
      );
    }
  }

  void _captureSessionHeaders(Map<String, String> headers) {
    for (final entry in headers.entries) {
      if (entry.key.toLowerCase() == 'cart-token' && entry.value.isNotEmpty) {
        _cartToken = entry.value;
      } else if (entry.key.toLowerCase() == 'nonce' && entry.value.isNotEmpty) {
        _nonce = entry.value;
      }
    }
  }

  static String? _readApiErrorCode(List<int> bodyBytes) {
    try {
      final decoded = jsonDecode(utf8.decode(bodyBytes));
      if (decoded is Map && decoded['code'] is String) {
        return (decoded['code'] as String).substring(
          0,
          (decoded['code'] as String).length.clamp(0, 120),
        );
      }
    } catch (_) {
      // Error bodies are intentionally not surfaced or logged.
    }
    return null;
  }

  static String _normalizeBaseUrl(
    String value, {
    required bool devProxyEnabled,
  }) {
    final uri = Uri.parse(value.trim());
    final isHttps = uri.scheme == 'https' && uri.host.isNotEmpty;
    final isDevProxy = kIsWeb &&
        kDebugMode &&
        devProxyEnabled &&
        uri.scheme == 'http' &&
        uri.host == _devProxyHost &&
        uri.port == _devProxyPort &&
        (uri.path.isEmpty || uri.path == '/') &&
        uri.userInfo.isEmpty &&
        uri.query.isEmpty &&
        uri.fragment.isEmpty;
    if ((!isHttps ||
            uri.userInfo.isNotEmpty ||
            uri.query.isNotEmpty ||
            uri.fragment.isNotEmpty ||
            (uri.path.isNotEmpty && uri.path != '/')) &&
        !isDevProxy) {
      throw ArgumentError.value(
        value,
        'baseUrl',
        'An HTTPS root URL is required (or the enabled Web debug proxy URL).',
      );
    }
    return value.trim().replaceFirst(RegExp(r'/+$'), '');
  }

  static bool _isAllowedRequestUri(Uri uri) {
    if (uri.scheme == 'https' && uri.host.isNotEmpty && uri.userInfo.isEmpty) {
      return true;
    }
    return kIsWeb &&
        kDebugMode &&
        const bool.fromEnvironment('ENABLE_WOOCOMMERCE_DEV_PROXY') &&
        uri.scheme == 'http' &&
        uri.host == _devProxyHost &&
        uri.port == _devProxyPort &&
        uri.userInfo.isEmpty;
  }
}
