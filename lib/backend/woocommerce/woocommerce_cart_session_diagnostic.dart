import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Performs a read-only, native HTTP diagnostic for the current Store API cart.
///
/// This diagnostic is intended for explicit VM/test use. It does not retain the
/// Cart-Token, response body, or any customer/cart data.
class WooCommerceCartSessionDiagnostic {
  WooCommerceCartSessionDiagnostic({
    http.Client? client,
    String baseUrl = 'https://el-emshaty-pharmacy.com',
    this.timeout = const Duration(seconds: 20),
  })  : _client = client ?? http.Client(),
        _baseUrl = _validateBaseUrl(baseUrl);

  final http.Client _client;
  final String _baseUrl;
  final Duration timeout;

  Future<WooCartSessionDiagnosticResult> run() async {
    if (kIsWeb) {
      return const WooCartSessionDiagnosticResult(
        statusCode: null,
        isValidJson: false,
        topLevelKeys: [],
        hasCartToken: false,
        errorCategory: 'browser_not_tested',
      );
    }
    final uri = Uri.parse('$_baseUrl/wp-json/wc/store/v1/cart');
    http.Response response;
    try {
      response = await _client.get(
        uri,
        headers: const {'Accept': 'application/json'},
      ).timeout(timeout);
    } on TimeoutException {
      return const WooCartSessionDiagnosticResult(
        statusCode: null,
        isValidJson: false,
        topLevelKeys: [],
        hasCartToken: false,
        errorCategory: 'timeout',
      );
    } on http.ClientException catch (error) {
      return WooCartSessionDiagnosticResult(
        statusCode: null,
        isValidJson: false,
        topLevelKeys: const [],
        hasCartToken: false,
        errorCategory: _classifyClientFailure(error),
      );
    } catch (error) {
      return WooCartSessionDiagnosticResult(
        statusCode: null,
        isValidJson: false,
        topLevelKeys: const [],
        hasCartToken: false,
        errorCategory: _classifyFailure(error),
      );
    }

    dynamic decoded;
    var isValidJson = false;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
      isValidJson = true;
    } on FormatException {
      // Keep the parse outcome only; never surface the response body.
    }

    final keys = decoded is Map
        ? decoded.keys.map((key) => key.toString()).toList(growable: false)
        : const <String>[];
    final hasCartToken = response.headers.entries.any(
      (entry) =>
          entry.key.toLowerCase() == 'cart-token' && entry.value.isNotEmpty,
    );

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;
    final errorCategory = !isSuccess
        ? 'http_error'
        : !isValidJson
            ? 'invalid_json'
            : !hasCartToken
                ? 'missing_cart_token'
                : 'none';

    return WooCartSessionDiagnosticResult(
      statusCode: response.statusCode,
      isValidJson: isValidJson,
      topLevelKeys: keys,
      hasCartToken: hasCartToken,
      errorCategory: errorCategory,
    );
  }

  static String _validateBaseUrl(String value) {
    final uri = Uri.parse(value.trim());
    if (uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.query.isNotEmpty ||
        uri.fragment.isNotEmpty ||
        (uri.path.isNotEmpty && uri.path != '/')) {
      throw ArgumentError.value(
        value,
        'baseUrl',
        'A root HTTPS URL without credentials is required.',
      );
    }
    return value.trim().replaceFirst(RegExp(r'/+$'), '');
  }

  static String _classifyClientFailure(http.ClientException error) {
    final message = error.message.toLowerCase();
    if (message.contains('tls') ||
        message.contains('handshake') ||
        message.contains('certificate')) {
      return 'tls_error';
    }
    return 'network_error';
  }

  static String _classifyFailure(Object error) {
    final type = error.runtimeType.toString().toLowerCase();
    if (type.contains('tls') ||
        type.contains('handshake') ||
        type.contains('certificate')) {
      return 'tls_error';
    }
    if (type.contains('socket') || type.contains('dns')) {
      return 'network_error';
    }
    return 'request_error';
  }
}

class WooCartSessionDiagnosticResult {
  const WooCartSessionDiagnosticResult({
    required this.statusCode,
    required this.isValidJson,
    required this.topLevelKeys,
    required this.hasCartToken,
    required this.errorCategory,
  });

  final int? statusCode;
  final bool isValidJson;
  final List<String> topLevelKeys;
  final bool hasCartToken;
  final String errorCategory;

  /// A safe summary containing no response values, token, URL, or exception text.
  String get diagnosticLine =>
      '[Woo cart diagnostic] status=${statusCode ?? 'none'} '
      'valid_json=$isValidJson top_level_keys=${topLevelKeys.join(',')} '
      'cart_token_present=$hasCartToken error_category=$errorCategory';
}
