import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'catalog_models.dart';

class WooCatalogException implements Exception {
  const WooCatalogException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class WooCommerceCatalogService {
  WooCommerceCatalogService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = _normalizeBaseUrl(
          baseUrl ??
              const String.fromEnvironment(
                'WOOCOMMERCE_BASE_URL',
                defaultValue: 'https://el-emshaty-pharmacy.com',
              ),
        );

  static final WooCommerceCatalogService instance = WooCommerceCatalogService();

  static const Duration _timeout = Duration(seconds: 20);
  static const Duration _cacheDuration = Duration(seconds: 30);
  static const bool _devProxyEnabled = bool.fromEnvironment(
    'ENABLE_WOOCOMMERCE_DEV_PROXY',
  );
  static const String _devProxyHost = '127.0.0.1';
  static const int _devProxyPort = 8787;

  final http.Client _client;
  final String _baseUrl;
  final Map<String, _CachedResponse> _cache = {};
  final Map<String, Future<_ResponseData>> _inFlight = {};

  Future<WooCatalogPage<WooProduct>> getProducts({
    int page = 1,
    int perPage = 12,
    String? search,
    int? categoryId,
    bool onSale = false,
  }) async {
    final query = <String, String>{
      'page': '${page < 1 ? 1 : page}',
      'per_page': '${perPage.clamp(1, 100)}',
    };
    if (search != null && search.trim().isNotEmpty) {
      query['search'] = search.trim();
    }
    if (categoryId != null && categoryId > 0) {
      query['category'] = '$categoryId';
    }
    if (onSale) query['on_sale'] = 'true';

    final response = await _getJson('/wp-json/wc/store/v1/products', query);
    final body = response.body;
    if (body is! List) {
      _logFailure(
        response.uri,
        classification: 'JSON parsing error',
        description: 'Expected a JSON list for products.',
        statusCode: response.statusCode,
      );
      throw const WooCatalogException(
          'The products response was not a JSON list.');
    }
    return WooCatalogPage<WooProduct>(
      items: body
          .whereType<Map>()
          .map((item) => WooProduct.fromJson(Map<String, dynamic>.from(item)))
          .toList(growable: false),
      page: page < 1 ? 1 : page,
      totalPages: _headerInt(
        response.headers,
        'x-wp-totalpages',
        fallback: body.length == perPage ? page + 1 : page,
      ),
    );
  }

  Future<WooProduct> getProduct(int productId) async {
    if (productId <= 0) {
      throw const WooCatalogException('A valid product ID is required.');
    }
    final response = await _getJson(
      '/wp-json/wc/store/v1/products/$productId',
      const {},
    );
    if (response.body is! Map) {
      _logFailure(
        response.uri,
        classification: 'JSON parsing error',
        description: 'Expected a JSON object for the product.',
        statusCode: response.statusCode,
      );
      throw const WooCatalogException(
          'The product response was not a JSON object.');
    }
    return WooProduct.fromJson(
      Map<String, dynamic>.from(response.body as Map),
    );
  }

  Future<WooCatalogPage<WooProductCategory>> getCategories({
    int page = 1,
    int perPage = 50,
  }) async {
    final response = await _getJson(
      '/wp-json/wc/store/v1/products/categories',
      {
        'page': '${page < 1 ? 1 : page}',
        'per_page': '${perPage.clamp(1, 100)}'
      },
    );
    final body = response.body;
    if (body is! List) {
      _logFailure(
        response.uri,
        classification: 'JSON parsing error',
        description: 'Expected a JSON list for product categories.',
        statusCode: response.statusCode,
      );
      throw const WooCatalogException(
          'The categories response was not a JSON list.');
    }
    return WooCatalogPage<WooProductCategory>(
      items: body
          .whereType<Map>()
          .map((item) => WooProductCategory.fromJson(
                Map<String, dynamic>.from(item),
              ))
          .toList(growable: false),
      page: page < 1 ? 1 : page,
      totalPages: _headerInt(
        response.headers,
        'x-wp-totalpages',
        fallback: body.length == perPage ? page + 1 : page,
      ),
    );
  }

  void clearCache() => _cache.clear();

  Future<_ResponseData> _getJson(String path, Map<String, String> query) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: query);
    final key = uri.toString();
    final cached = _cache[key];
    if (cached != null &&
        DateTime.now().difference(cached.savedAt) < _cacheDuration) {
      return cached.response;
    }
    final pending = _inFlight[key];
    if (pending != null) return pending;

    final request = _request(uri);
    _inFlight[key] = request;
    try {
      final response = await request;
      _cache[key] = _CachedResponse(response, DateTime.now());
      return response;
    } finally {
      _inFlight.remove(key);
    }
  }

  Future<_ResponseData> _request(Uri uri) async {
    if (!_isAllowedRequestUri(uri)) {
      throw const WooCatalogException('The catalog service requires HTTPS.');
    }
    _logRequest(uri);
    try {
      final response = await _client.get(uri,
          headers: const {'Accept': 'application/json'}).timeout(_timeout);
      final contentType = response.headers['content-type'] ?? '';
      _logResponse(uri, response.statusCode);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        _logFailure(
          uri,
          classification: 'non-success HTTP response',
          description: 'The server returned HTTP ${response.statusCode}.',
          statusCode: response.statusCode,
        );
        throw WooCatalogException(
          'Catalog request failed (${response.statusCode}).',
          statusCode: response.statusCode,
        );
      }
      if (!contentType.toLowerCase().contains('application/json')) {
        _logFailure(
          uri,
          classification: 'unexpected content type',
          description: 'The response was not application/json.',
          statusCode: response.statusCode,
        );
        throw const WooCatalogException(
          'The catalog endpoint did not return application/json.',
        );
      }
      dynamic body;
      try {
        body = jsonDecode(utf8.decode(response.bodyBytes));
      } on FormatException {
        _logFailure(
          uri,
          classification: 'JSON parsing error',
          description: 'The response body was not valid JSON text.',
          statusCode: response.statusCode,
        );
        throw const WooCatalogException('The catalog returned malformed JSON.');
      }
      return _ResponseData(uri, body, response.headers, response.statusCode);
    } on TimeoutException catch (error) {
      _logFailure(
        uri,
        classification: 'timeout',
        description: _sanitizeError(error),
      );
      throw const WooCatalogException('The catalog request timed out.');
    } on http.ClientException catch (error) {
      _logFailure(
        uri,
        classification: _classifyNetworkFailure(error),
        description: _sanitizeError(error),
      );
      throw const WooCatalogException(
        'Could not reach the product catalog. Check your connection and try again.',
      );
    } on WooCatalogException {
      rethrow;
    } catch (error) {
      final type = error.runtimeType.toString().toLowerCase();
      final classification = type.contains('handshake') ||
              type.contains('tls') ||
              type.contains('certificate')
          ? 'TLS error'
          : type.contains('socket') || type.contains('dns')
              ? 'DNS/network error'
              : kIsWeb
                  ? 'browser/network restriction (CORS may be involved)'
                  : 'network error';
      _logFailure(
        uri,
        classification: classification,
        description: _sanitizeError(error),
      );
      throw const WooCatalogException(
        'Could not reach the product catalog. Check your connection and try again.',
      );
    }
  }

  static String _classifyNetworkFailure(Object error) {
    final type = error.runtimeType.toString().toLowerCase();
    final message = _sanitizeError(error).toLowerCase();
    if (type.contains('handshake') ||
        type.contains('tls') ||
        type.contains('certificate') ||
        message.contains('tls') ||
        message.contains('certificate') ||
        message.contains('handshake')) {
      return 'TLS error';
    }
    if (type.contains('socket') ||
        type.contains('dns') ||
        message.contains('failed host lookup') ||
        message.contains('name or service not known') ||
        message.contains('no address associated with hostname')) {
      return 'DNS/network error';
    }
    if (kIsWeb) {
      return 'browser/network restriction (CORS may be involved)';
    }
    return 'network error';
  }

  static void _logRequest(Uri uri) {
    if (kDebugMode) {
      debugPrint('[WooCatalog] GET ${_diagnosticUrl(uri)}');
    }
  }

  static void _logResponse(Uri uri, int statusCode) {
    if (kDebugMode) {
      debugPrint(
        '[WooCatalog] response URL=${_diagnosticUrl(uri)} status=$statusCode',
      );
    }
  }

  static void _logFailure(
    Uri uri, {
    required String classification,
    required String description,
    int? statusCode,
  }) {
    if (!kDebugMode) return;
    debugPrint(
      '[WooCatalog] failure URL=${_diagnosticUrl(uri)} '
      'status=${statusCode ?? 'none'} type=$classification '
      'detail=${_sanitizeError(description)}',
    );
  }

  static String _diagnosticUrl(Uri uri) {
    final safeQuery = Map<String, String>.from(uri.queryParameters);
    if (safeQuery.containsKey('search')) safeQuery['search'] = '[redacted]';
    return uri.replace(userInfo: '', queryParameters: safeQuery).toString();
  }

  static String _sanitizeError(Object error) {
    final description =
        error is http.ClientException ? error.message : '$error';
    final sanitized = description
        .replaceAll(RegExp(r'https?://[^\s]+'), '[url]')
        .replaceAll(
          RegExp(
              r'(authorization|cookie|token|password|secret)\s*[:=]\s*[^\s,;]+',
              caseSensitive: false),
          '[redacted]',
        )
        .replaceAll(RegExp(r'[\r\n\t]+'), ' ')
        .trim();
    return sanitized.length <= 160
        ? sanitized
        : '${sanitized.substring(0, 160)}...';
  }

  static int _headerInt(Map<String, String> headers, String key,
      {required int fallback}) {
    final value = headers.entries
        .where((entry) => entry.key.toLowerCase() == key)
        .map((entry) => entry.value)
        .firstOrNull;
    return int.tryParse(value ?? '') ?? fallback;
  }

  static String _normalizeBaseUrl(String value) {
    final uri = Uri.parse(value.trim());
    final isHttps = uri.scheme == 'https' && uri.host.isNotEmpty;
    final isDevProxy = kIsWeb &&
        kDebugMode &&
        _devProxyEnabled &&
        uri.scheme == 'http' &&
        uri.host == _devProxyHost &&
        uri.port == _devProxyPort &&
        (uri.path.isEmpty || uri.path == '/') &&
        uri.userInfo.isEmpty &&
        uri.query.isEmpty &&
        uri.fragment.isEmpty;
    if (!isHttps && !isDevProxy) {
      throw ArgumentError.value(
        value,
        'baseUrl',
        'An HTTPS URL is required (or the enabled Web debug proxy URL).',
      );
    }
    return value.trim().replaceFirst(RegExp(r'/+$'), '');
  }

  static bool _isAllowedRequestUri(Uri uri) {
    if (uri.scheme == 'https' && uri.host.isNotEmpty) return true;
    return kIsWeb &&
        kDebugMode &&
        _devProxyEnabled &&
        uri.scheme == 'http' &&
        uri.host == _devProxyHost &&
        uri.port == _devProxyPort &&
        uri.userInfo.isEmpty;
  }
}

class _ResponseData {
  const _ResponseData(this.uri, this.body, this.headers, this.statusCode);

  final Uri uri;
  final dynamic body;
  final Map<String, String> headers;
  final int statusCode;
}

class _CachedResponse {
  const _CachedResponse(this.response, this.savedAt);

  final _ResponseData response;
  final DateTime savedAt;
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
