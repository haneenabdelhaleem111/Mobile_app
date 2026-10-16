import 'dart:async';
import 'dart:convert';
import 'dart:io';

const String _allowedOrigin = 'http://localhost:5000';
const String _upstreamHost = 'el-emshaty-pharmacy.com';
const int _proxyPort = 8787;
const int _maxCartBodyBytes = 64 * 1024;
const Set<String> _allowedQueryParameters = {
  'page',
  'per_page',
  'search',
  'category',
  'on_sale',
};
const Map<String, String> _cartHeaderNames = {
  'content-type': 'Content-Type',
  'cart-token': 'Cart-Token',
  'nonce': 'Nonce',
};

const String _checkoutPath = '/wp-json/wc/store/v1/checkout';

const Set<String> _cartPaths = {
  '/wp-json/wc/store/v1/cart',
  '/wp-json/wc/store/v1/cart/add-item',
  '/wp-json/wc/store/v1/cart/update-item',
  '/wp-json/wc/store/v1/cart/remove-item',
};

bool isAllowedWooCatalogPath(String path) {
  return path == '/wp-json/wc/store/v1/products' ||
      path == '/wp-json/wc/store/v1/products/categories' ||
      RegExp(r'^/wp-json/wc/store/v1/products/\d+$').hasMatch(path);
}

bool isAllowedWooCatalogMethod(String method) =>
    method == 'GET' || method == 'OPTIONS';

bool isAllowedWooCartPath(String path) => _cartPaths.contains(path);

bool isAllowedWooCartMethod(String path, String method) {
  if (path == '/wp-json/wc/store/v1/cart') return method == 'GET';
  if (_cartPaths.contains(path)) return method == 'POST';
  return false;
}

bool isAllowedWooCheckoutPath(String path) => path == _checkoutPath;

bool isAllowedWooCheckoutMethod(String path, String method) =>
    isAllowedWooCheckoutPath(path) &&
    const {'GET', 'PUT', 'POST'}.contains(method);

bool isAllowedWooCatalogOrigin(String? origin) => origin == _allowedOrigin;

Map<String, String> wooCatalogProxyCorsHeaders(String? origin) {
  if (!isAllowedWooCatalogOrigin(origin)) return const {};
  return const {
    'Access-Control-Allow-Origin': _allowedOrigin,
    'Access-Control-Allow-Methods': 'GET',
    'Vary': 'Origin',
  };
}

/// This callback is injectable only so proxy behavior can be tested without
/// making network requests. The production entry point always uses the fixed
/// HTTPS upstream below.
typedef WooProxyUpstreamRequest = Future<WooProxyUpstreamResponse> Function(
  Uri uri,
  String method,
  Map<String, String> headers,
  List<int> body,
);

class WooProxyUpstreamResponse {
  const WooProxyUpstreamResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
  });

  final int statusCode;
  final Map<String, String> headers;
  final List<int> body;
}

Future<void> main() async {
  final server =
      await HttpServer.bind(InternetAddress.loopbackIPv4, _proxyPort);
  stdout.writeln(
    'WooCommerce catalog dev proxy listening on http://127.0.0.1:$_proxyPort',
  );
  stdout.writeln('Upstream is fixed to https://$_upstreamHost');
  await for (final request in server) {
    unawaited(handleWooCatalogProxyRequest(request));
  }
}

Future<void> handleWooCatalogProxyRequest(
  HttpRequest request, {
  WooProxyUpstreamRequest? upstreamRequest,
}) async {
  final response = request.response;
  final origin = request.headers.value('origin');
  final path = request.uri.path;
  final isCartRoute = isAllowedWooCartPath(path);
  final isCheckoutRoute = isAllowedWooCheckoutPath(path);
  final isSessionRoute = isCartRoute || isCheckoutRoute;

  if (!isAllowedWooCatalogOrigin(origin)) {
    await _reject(response, HttpStatus.forbidden, 'Origin not allowed.');
    return;
  }

  if (!isAllowedWooCatalogPath(path) && !isSessionRoute) {
    _applyCorsHeaders(response, _corsHeadersFor(path));
    await _reject(response, HttpStatus.notFound, 'Route not allowed.');
    return;
  }
  _applyCorsHeaders(response, _corsHeadersFor(path));

  if (request.method == 'OPTIONS') {
    await _handlePreflight(request, isSessionRoute: isSessionRoute);
    return;
  }

  final methodAllowed = isCartRoute
      ? isAllowedWooCartMethod(path, request.method)
      : isCheckoutRoute
          ? isAllowedWooCheckoutMethod(path, request.method)
          : request.method == 'GET';
  if (!methodAllowed) {
    final allow = isCartRoute
        ? (path == '/wp-json/wc/store/v1/cart'
            ? 'GET, OPTIONS'
            : 'POST, OPTIONS')
        : isCheckoutRoute
            ? 'GET, PUT, POST, OPTIONS'
            : 'GET, OPTIONS';
    response.headers.set(HttpHeaders.allowHeader, allow);
    await _reject(response, HttpStatus.methodNotAllowed, 'Method not allowed.');
    return;
  }

  List<int> body = const [];
  if (isCartRoute) {
    if (request.uri.hasQuery) {
      await _reject(response, HttpStatus.badRequest,
          'Cart query parameters are not allowed.');
      return;
    }
    if (request.method == 'POST') {
      final contentType = request.headers.contentType;
      if (contentType?.mimeType.toLowerCase() != 'application/json') {
        await _reject(
            response, HttpStatus.unsupportedMediaType, 'JSON body required.');
        return;
      }
      final readResult = await _readCartJsonBody(request);
      if (readResult.error != null) {
        await _reject(response, readResult.statusCode!, readResult.error!);
        return;
      }
      body = readResult.body!;
      if (!_isValidMutationBody(path, body)) {
        await _reject(
            response, HttpStatus.badRequest, 'Invalid cart request body.');
        return;
      }
    }
  } else if (isCheckoutRoute) {
    final allowedQuery =
        request.method == 'PUT' ? {'__experimental_calc_totals'} : <String>{};
    if (request.uri.queryParameters.keys
            .any((key) => !allowedQuery.contains(key)) ||
        (request.uri.queryParameters['__experimental_calc_totals'] != null &&
            !const {'true', 'false'}.contains(
              request.uri.queryParameters['__experimental_calc_totals'],
            ))) {
      await _reject(response, HttpStatus.badRequest,
          'Checkout query parameter not allowed.');
      return;
    }
    if (request.method != 'GET') {
      final contentType = request.headers.contentType;
      if (contentType?.mimeType.toLowerCase() != 'application/json') {
        await _reject(
            response, HttpStatus.unsupportedMediaType, 'JSON body required.');
        return;
      }
      final readResult = await _readCartJsonBody(request);
      if (readResult.error != null) {
        await _reject(response, readResult.statusCode!, readResult.error!);
        return;
      }
      body = readResult.body!;
      if (!_isValidCheckoutBody(request.method, body)) {
        await _reject(
            response, HttpStatus.badRequest, 'Invalid checkout request body.');
        return;
      }
    }
  } else if (request.uri.queryParameters.keys
      .any((key) => !_allowedQueryParameters.contains(key))) {
    await _reject(
        response, HttpStatus.badRequest, 'Query parameter not allowed.');
    return;
  }

  final upstreamUri = Uri.https(
    _upstreamHost,
    path,
    request.uri.queryParameters.isEmpty ? null : request.uri.queryParameters,
  );
  final forwardHeaders = <String, String>{'Accept': 'application/json'};
  if (isSessionRoute) {
    final contentType = request.headers.value(HttpHeaders.contentTypeHeader);
    final cartToken = request.headers.value('Cart-Token');
    final nonce = request.headers.value('Nonce');
    if (contentType != null && request.method == 'POST') {
      forwardHeaders['Content-Type'] = contentType;
    }
    if (contentType != null && request.method == 'PUT') {
      forwardHeaders['Content-Type'] = contentType;
    }
    if (cartToken != null && cartToken.isNotEmpty) {
      forwardHeaders['Cart-Token'] = cartToken;
    }
    if (nonce != null && nonce.isNotEmpty) {
      forwardHeaders['Nonce'] = nonce;
    }
  }

  try {
    final upstreamResponse = await (upstreamRequest ?? _sendToFixedUpstream)(
      upstreamUri,
      request.method,
      forwardHeaders,
      body,
    );
    response.statusCode = upstreamResponse.statusCode;
    for (final name in const [
      HttpHeaders.contentTypeHeader,
      'x-wp-total',
      'x-wp-totalpages',
      'link',
    ]) {
      final value = _headerValue(upstreamResponse.headers, name);
      if (value != null) response.headers.set(name, value);
    }
    if (isSessionRoute) {
      final cartToken = _headerValue(upstreamResponse.headers, 'Cart-Token');
      if (cartToken != null && cartToken.isNotEmpty) {
        response.headers.set('Cart-Token', cartToken);
      }
      final nonce = _headerValue(upstreamResponse.headers, 'Nonce');
      if (nonce != null && nonce.isNotEmpty) {
        response.headers.set('Nonce', nonce);
      }
    }
    response.add(upstreamResponse.body);
    await response.close();
  } on TimeoutException {
    await _reject(response, HttpStatus.badGateway, 'Upstream timed out.');
  } on SocketException {
    await _reject(response, HttpStatus.badGateway, 'Upstream unavailable.');
  } on TlsException {
    await _reject(
        response, HttpStatus.badGateway, 'Upstream TLS validation failed.');
  } catch (_) {
    await _reject(response, HttpStatus.badGateway, 'Upstream request failed.');
  }
}

Future<void> _handlePreflight(
  HttpRequest request, {
  required bool isSessionRoute,
}) async {
  final response = request.response;
  final path = request.uri.path;
  final requestedMethod =
      request.headers.value('access-control-request-method')?.toUpperCase();
  final requestedHeaders =
      (request.headers.value('access-control-request-headers') ?? '')
          .split(',')
          .map((header) => header.trim().toLowerCase())
          .where((header) => header.isNotEmpty)
          .toSet();

  final allowedMethod = isSessionRoute
      ? isAllowedWooCartMethod(path, requestedMethod ?? '') ||
          isAllowedWooCheckoutMethod(path, requestedMethod ?? '')
      : requestedMethod == 'GET';
  final headersAllowed = isSessionRoute
      ? requestedHeaders.every(_cartHeaderNames.containsKey)
      : requestedHeaders.isEmpty;
  if (!allowedMethod || !headersAllowed) {
    final allowed = isAllowedWooCheckoutPath(path)
        ? 'GET, PUT, POST, OPTIONS'
        : isSessionRoute
            ? (path == '/wp-json/wc/store/v1/cart'
                ? 'GET, OPTIONS'
                : 'POST, OPTIONS')
            : 'GET, OPTIONS';
    response.headers.set(HttpHeaders.allowHeader, allowed);
    await _reject(
        response, HttpStatus.methodNotAllowed, 'Preflight not allowed.');
    return;
  }

  final methods = isAllowedWooCheckoutPath(path)
      ? 'GET, PUT, POST'
      : isSessionRoute
          ? (path == '/wp-json/wc/store/v1/cart' ? 'GET' : 'POST')
          : 'GET';
  response.headers.set('Access-Control-Allow-Methods', methods);
  if (requestedHeaders.isNotEmpty) {
    final allowedHeaders = requestedHeaders
        .map((header) => _cartHeaderNames[header]!)
        .toList()
      ..sort();
    response.headers.set(
      'Access-Control-Allow-Headers',
      allowedHeaders.join(', '),
    );
  }
  response.statusCode = HttpStatus.noContent;
  await response.close();
}

Map<String, String> _corsHeadersFor(String path) {
  if (isAllowedWooCartPath(path) || isAllowedWooCheckoutPath(path)) {
    return {
      'Access-Control-Allow-Origin': _allowedOrigin,
      'Access-Control-Allow-Methods': isAllowedWooCheckoutPath(path)
          ? 'GET, PUT, POST'
          : path == '/wp-json/wc/store/v1/cart'
              ? 'GET'
              : 'POST',
      'Access-Control-Expose-Headers': 'Cart-Token, Nonce',
      'Vary': 'Origin',
    };
  }
  return wooCatalogProxyCorsHeaders(_allowedOrigin);
}

void _applyCorsHeaders(HttpResponse response, Map<String, String> headers) {
  for (final entry in headers.entries) {
    response.headers.set(entry.key, entry.value);
  }
}

Future<_BodyReadResult> _readCartJsonBody(HttpRequest request) async {
  if (request.contentLength > _maxCartBodyBytes) {
    return const _BodyReadResult.error(
      HttpStatus.requestEntityTooLarge,
      'Cart request body is too large.',
    );
  }
  final bytes = <int>[];
  try {
    await for (final chunk in request) {
      if (bytes.length + chunk.length > _maxCartBodyBytes) {
        return const _BodyReadResult.error(
          HttpStatus.requestEntityTooLarge,
          'Cart request body is too large.',
        );
      }
      bytes.addAll(chunk);
    }
    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map) {
      return const _BodyReadResult.error(
        HttpStatus.badRequest,
        'Cart request body must be a JSON object.',
      );
    }
    return _BodyReadResult.success(bytes);
  } on FormatException {
    return const _BodyReadResult.error(
      HttpStatus.badRequest,
      'Cart request body must be valid JSON.',
    );
  }
}

bool _isValidMutationBody(String path, List<int> bytes) {
  final decoded = jsonDecode(utf8.decode(bytes));
  if (decoded is! Map<String, dynamic>) return false;
  if (path.endsWith('/add-item')) {
    final allowedKeys = {'id', 'quantity', 'variation'};
    return decoded.keys.every(allowedKeys.contains) &&
        decoded['id'] is int &&
        decoded['id'] > 0 &&
        decoded['quantity'] is int &&
        decoded['quantity'] > 0 &&
        (decoded['variation'] == null ||
            _isValidVariation(decoded['variation']));
  }
  if (path.endsWith('/update-item')) {
    return decoded.keys.toSet().difference({'key', 'quantity'}).isEmpty &&
        decoded['key'] is String &&
        (decoded['key'] as String).isNotEmpty &&
        decoded['quantity'] is int &&
        decoded['quantity'] > 0;
  }
  if (path.endsWith('/remove-item')) {
    return decoded.keys.toSet().difference({'key'}).isEmpty &&
        decoded['key'] is String &&
        (decoded['key'] as String).isNotEmpty;
  }
  return false;
}

bool _isValidCheckoutBody(String method, List<int> bytes) {
  final decoded = jsonDecode(utf8.decode(bytes));
  if (decoded is! Map<String, dynamic>) return false;
  if (method == 'PUT') {
    const allowed = {'additional_fields', 'payment_method', 'order_notes'};
    return decoded.keys.every(allowed.contains) &&
        (decoded['additional_fields'] == null ||
            decoded['additional_fields'] is Map) &&
        (decoded['payment_method'] == null ||
            decoded['payment_method'] is String) &&
        (decoded['order_notes'] == null || decoded['order_notes'] is String);
  }
  if (method == 'POST') {
    const allowed = {
      'billing_address',
      'shipping_address',
      'customer_note',
      'payment_method',
      'payment_data',
      'expected_total',
    };
    return decoded.keys.every(allowed.contains) &&
        decoded['billing_address'] is Map &&
        decoded['shipping_address'] is Map &&
        decoded['payment_method'] is String &&
        (decoded['customer_note'] == null ||
            decoded['customer_note'] is String) &&
        (decoded['payment_data'] == null || decoded['payment_data'] is List) &&
        (decoded['expected_total'] == null ||
            decoded['expected_total'] is String);
  }
  return false;
}

bool _isValidVariation(dynamic value) {
  if (value is! List) return false;
  return value.every((item) =>
      item is Map && item['attribute'] is String && item['value'] is String);
}

Future<WooProxyUpstreamResponse> _sendToFixedUpstream(
  Uri uri,
  String method,
  Map<String, String> headers,
  List<int> body,
) async {
  if (uri.scheme != 'https' || uri.host != _upstreamHost) {
    throw const SocketException('Fixed upstream validation failed.');
  }
  final client =
      HttpClient(); // Default TLS certificate validation remains enabled.
  try {
    final upstreamRequest = await client.openUrl(method, uri).timeout(
          const Duration(seconds: 20),
        );
    for (final entry in headers.entries) {
      upstreamRequest.headers.set(entry.key, entry.value);
    }
    if (body.isNotEmpty) upstreamRequest.add(body);
    final upstreamResponse = await upstreamRequest.close().timeout(
          const Duration(seconds: 20),
        );
    final responseHeaders = <String, String>{};
    for (final name in const [
      HttpHeaders.contentTypeHeader,
      'x-wp-total',
      'x-wp-totalpages',
      'link',
      'Cart-Token',
      'Nonce',
    ]) {
      final value = upstreamResponse.headers.value(name);
      if (value != null) responseHeaders[name] = value;
    }
    final responseBody = await upstreamResponse.fold<List<int>>(
      <int>[],
      (all, chunk) => all..addAll(chunk),
    );
    return WooProxyUpstreamResponse(
      statusCode: upstreamResponse.statusCode,
      headers: responseHeaders,
      body: responseBody,
    );
  } finally {
    client.close(force: true);
  }
}

String? _headerValue(Map<String, String> headers, String key) {
  for (final entry in headers.entries) {
    if (entry.key.toLowerCase() == key.toLowerCase()) return entry.value;
  }
  return null;
}

Future<void> _reject(HttpResponse response, int status, String message) async {
  response.statusCode = status;
  response.headers.contentType = ContentType.json;
  response.write(jsonEncode({'error': message}));
  await response.close();
}

class _BodyReadResult {
  const _BodyReadResult.success(this.body)
      : error = null,
        statusCode = null;
  const _BodyReadResult.error(this.statusCode, this.error) : body = null;

  final List<int>? body;
  final String? error;
  final int? statusCode;
}
