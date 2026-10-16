import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../tool/woocommerce_catalog_dev_proxy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  late HttpServer server;
  late Uri baseUri;
  late List<(Uri, String, Map<String, String>, List<int>)> upstreamCalls;
  late WooProxyUpstreamRequest fakeUpstream;

  setUp(() async {
    upstreamCalls = [];
    fakeUpstream = (uri, method, headers, body) async {
      upstreamCalls.add((uri, method, Map.of(headers), List.of(body)));
      return WooProxyUpstreamResponse(
        statusCode: HttpStatus.ok,
        headers: const {
          'content-type': 'application/json',
          'Cart-Token': 'test-token-value',
          'Nonce': 'test-nonce-value',
          'Set-Cookie': 'must-not-be-forwarded',
        },
        body: utf8.encode('{"items":[],"totals":{}}'),
      );
    };
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    unawaited(server.forEach((request) => handleWooCatalogProxyRequest(
          request,
          upstreamRequest: fakeUpstream,
        )));
    baseUri = Uri(
      scheme: 'http',
      host: '127.0.0.1',
      port: server.port,
    );
  });

  tearDown(() async {
    await server.close(force: true);
  });

  test('allows catalog routes and only their existing GET/OPTIONS behavior',
      () {
    expect(isAllowedWooCatalogPath('/wp-json/wc/store/v1/products'), isTrue);
    expect(
      isAllowedWooCatalogPath('/wp-json/wc/store/v1/products/categories'),
      isTrue,
    );
    expect(isAllowedWooCatalogPath('/wp-json/wc/store/v1/products/42'), isTrue);
    expect(isAllowedWooCatalogPath('/wp-json/wc/store/v1/orders'), isFalse);
    expect(isAllowedWooCatalogPath('/wp-json/wc/store/v1/products/42/reviews'),
        isFalse);
    expect(isAllowedWooCatalogMethod('GET'), isTrue);
    expect(isAllowedWooCatalogMethod('OPTIONS'), isTrue);
    expect(isAllowedWooCatalogMethod('POST'), isFalse);
    expect(isAllowedWooCatalogMethod('PUT'), isFalse);
  });

  test('allows only the exact cart routes and their designated methods', () {
    const base = '/wp-json/wc/store/v1/cart';
    const add = '$base/add-item';
    const update = '$base/update-item';
    const remove = '$base/remove-item';
    for (final path in [base, add, update, remove]) {
      expect(isAllowedWooCartPath(path), isTrue);
    }
    expect(isAllowedWooCartPath('$base/items'), isFalse);
    expect(isAllowedWooCartPath('/wp-json/wc/store/v1/checkout'), isFalse);
    expect(isAllowedWooCartMethod(base, 'GET'), isTrue);
    expect(isAllowedWooCartMethod(base, 'POST'), isFalse);
    for (final path in [add, update, remove]) {
      expect(isAllowedWooCartMethod(path, 'POST'), isTrue);
      expect(isAllowedWooCartMethod(path, 'GET'), isFalse);
      expect(isAllowedWooCartMethod(path, 'PUT'), isFalse);
      expect(isAllowedWooCartMethod(path, 'DELETE'), isFalse);
    }
  });

  test('allows checkout only on its exact route and documented methods', () {
    const checkout = '/wp-json/wc/store/v1/checkout';
    expect(isAllowedWooCheckoutPath(checkout), isTrue);
    expect(isAllowedWooCheckoutPath('$checkout/anything'), isFalse);
    for (final method in ['GET', 'PUT', 'POST']) {
      expect(isAllowedWooCheckoutMethod(checkout, method), isTrue);
    }
    for (final method in ['PATCH', 'DELETE', 'OPTIONS']) {
      expect(isAllowedWooCheckoutMethod(checkout, method), isFalse);
    }
  });

  test('rejects unapproved paths and write methods over HTTP', () async {
    final pathResponse = await http.get(
      baseUri.replace(path: '/wp-json/wc/store/v1/orders'),
      headers: const {'Origin': 'http://localhost:5000'},
    );
    final methodResponse = await http.post(
      baseUri.replace(path: '/wp-json/wc/store/v1/products'),
      headers: const {'Origin': 'http://localhost:5000'},
    );

    expect(pathResponse.statusCode, HttpStatus.notFound);
    expect(methodResponse.statusCode, HttpStatus.methodNotAllowed);
    expect(methodResponse.headers['allow'], 'GET, OPTIONS');
  });

  test('serves exact-origin preflight without credentials or auth headers',
      () async {
    final response = http.Request(
      'OPTIONS',
      baseUri.replace(path: '/wp-json/wc/store/v1/products'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Access-Control-Request-Method'] = 'GET';
    final client = http.Client();
    final streamedResponse = await client.send(response);
    final result = await http.Response.fromStream(streamedResponse);
    client.close();

    expect(result.statusCode, HttpStatus.noContent);
    expect(
        result.headers['access-control-allow-origin'], 'http://localhost:5000');
    expect(result.headers['access-control-allow-methods'], 'GET');
    expect(result.headers.containsKey('access-control-allow-credentials'),
        isFalse);
    expect(result.headers.containsKey('access-control-allow-headers'), isFalse);
  });

  test('rejects other origins and does not grant CORS access', () async {
    final response = await http.get(
      baseUri.replace(path: '/wp-json/wc/store/v1/products'),
      headers: const {'Origin': 'http://localhost:5001'},
    );

    expect(response.statusCode, HttpStatus.forbidden);
    expect(
        response.headers.containsKey('access-control-allow-origin'), isFalse);
  });

  test('rejects preflight for methods or headers outside catalog GET',
      () async {
    final response = http.Request(
      'OPTIONS',
      baseUri.replace(path: '/wp-json/wc/store/v1/products'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Access-Control-Request-Method'] = 'POST'
      ..headers['Access-Control-Request-Headers'] = 'authorization';
    final client = http.Client();
    final result = await client.send(response);

    expect(result.statusCode, HttpStatus.methodNotAllowed);
    expect(
        result.headers['access-control-allow-origin'], 'http://localhost:5000');
    expect(result.headers.containsKey('access-control-allow-headers'), isFalse);
    await result.stream.drain<void>();
    client.close();
  });

  test('allows cart preflight only for exact origin and approved headers',
      () async {
    final request = http.Request(
      'OPTIONS',
      baseUri.replace(path: '/wp-json/wc/store/v1/cart/add-item'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Access-Control-Request-Method'] = 'POST'
      ..headers['Access-Control-Request-Headers'] = 'content-type,cart-token';
    final client = http.Client();
    final result = await http.Response.fromStream(await client.send(request));
    client.close();

    expect(result.statusCode, HttpStatus.noContent);
    expect(
        result.headers['access-control-allow-origin'], 'http://localhost:5000');
    expect(result.headers['access-control-allow-methods'], 'POST');
    expect(result.headers['access-control-allow-headers'],
        'Cart-Token, Content-Type');
    expect(result.headers.containsKey('access-control-allow-credentials'),
        isFalse);
    expect(upstreamCalls, isEmpty);
  });

  test('forwards cart token and JSON body through a mock fixed-upstream call',
      () async {
    final request = http.Request(
      'POST',
      baseUri.replace(path: '/wp-json/wc/store/v1/cart/add-item'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Content-Type'] = 'application/json'
      ..headers['Cart-Token'] = 'incoming-test-token'
      ..headers['Cookie'] = 'private-cookie=must-not-forward'
      ..headers['Authorization'] = 'Bearer must-not-forward'
      ..headers['X-Arbitrary'] = 'must-not-forward'
      ..body = '{"id":31,"quantity":2}';
    final client = http.Client();
    final result = await http.Response.fromStream(await client.send(request));
    client.close();

    expect(result.statusCode, HttpStatus.ok);
    expect(upstreamCalls, hasLength(1));
    final (uri, method, headers, body) = upstreamCalls.single;
    expect(uri.toString(),
        'https://el-emshaty-pharmacy.com/wp-json/wc/store/v1/cart/add-item');
    expect(method, 'POST');
    expect(headers, const {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
      'Cart-Token': 'incoming-test-token',
    });
    expect(jsonDecode(utf8.decode(body)), {'id': 31, 'quantity': 2});
    expect(result.headers['cart-token'], 'test-token-value');
    expect(
        result.headers['access-control-expose-headers'], 'Cart-Token, Nonce');
    expect(result.headers['nonce'], 'test-nonce-value');
    expect(result.headers.containsKey('set-cookie'), isFalse);
    expect(result.headers.containsKey('access-control-allow-credentials'),
        isFalse);
    expect(result.body, '{"items":[],"totals":{}}');
  });

  test('preflights exact checkout origin, methods, and approved headers',
      () async {
    final request = http.Request(
      'OPTIONS',
      baseUri.replace(path: '/wp-json/wc/store/v1/checkout'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Access-Control-Request-Method'] = 'PUT'
      ..headers['Access-Control-Request-Headers'] =
          'content-type,cart-token,nonce';
    final client = http.Client();
    final result = await http.Response.fromStream(await client.send(request));
    client.close();

    expect(result.statusCode, HttpStatus.noContent);
    expect(
        result.headers['access-control-allow-origin'], 'http://localhost:5000');
    expect(result.headers['access-control-allow-methods'], 'GET, PUT, POST');
    expect(result.headers['access-control-allow-headers'],
        'Cart-Token, Content-Type, Nonce');
    expect(
        result.headers['access-control-expose-headers'], 'Cart-Token, Nonce');
    expect(upstreamCalls, isEmpty);
  });

  test('forwards checkout PUT only to fixed upstream with approved headers',
      () async {
    final request = http.Request(
      'PUT',
      baseUri.replace(
        path: '/wp-json/wc/store/v1/checkout',
        queryParameters: {'__experimental_calc_totals': 'true'},
      ),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Content-Type'] = 'application/json'
      ..headers['Cart-Token'] = 'checkout-session-token'
      ..headers['Cookie'] = 'must-not-forward'
      ..headers['Authorization'] = 'must-not-forward'
      ..headers['X-Arbitrary'] = 'must-not-forward'
      ..body = '{"payment_method":"cod","order_notes":"Leave safely"}';
    final client = http.Client();
    final result = await http.Response.fromStream(await client.send(request));
    client.close();

    expect(result.statusCode, HttpStatus.ok);
    final (uri, method, headers, body) = upstreamCalls.single;
    expect(uri.toString(),
        'https://el-emshaty-pharmacy.com/wp-json/wc/store/v1/checkout?__experimental_calc_totals=true');
    expect(method, 'PUT');
    expect(headers, const {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
      'Cart-Token': 'checkout-session-token',
    });
    expect(jsonDecode(utf8.decode(body)), {
      'payment_method': 'cod',
      'order_notes': 'Leave safely',
    });
    expect(
        result.headers['access-control-expose-headers'], 'Cart-Token, Nonce');
  });

  test('rejects checkout unsupported method, query, and body fields', () async {
    const path = '/wp-json/wc/store/v1/checkout';
    final wrongMethod = await http.delete(
      baseUri.replace(path: path),
      headers: const {'Origin': 'http://localhost:5000'},
    );
    final badQuery = await http.put(
      baseUri.replace(path: path, queryParameters: {'arbitrary': '1'}),
      headers: const {
        'Origin': 'http://localhost:5000',
        'Content-Type': 'application/json',
      },
      body: '{}',
    );
    final badBody = await http.put(
      baseUri.replace(path: path),
      headers: const {
        'Origin': 'http://localhost:5000',
        'Content-Type': 'application/json',
      },
      body: '{"payment_method":"cod","unexpected":"field"}',
    );

    expect(wrongMethod.statusCode, HttpStatus.methodNotAllowed);
    expect(badQuery.statusCode, HttpStatus.badRequest);
    expect(badBody.statusCode, HttpStatus.badRequest);
    expect(upstreamCalls, isEmpty);
  });

  test('rejects malformed or unsupported cart request bodies before forwarding',
      () async {
    final malformed = http.Request(
      'POST',
      baseUri.replace(path: '/wp-json/wc/store/v1/cart/add-item'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Content-Type'] = 'application/json'
      ..body = '{not json';
    final invalidShape = http.Request(
      'POST',
      baseUri.replace(path: '/wp-json/wc/store/v1/cart/remove-item'),
    )
      ..headers['Origin'] = 'http://localhost:5000'
      ..headers['Content-Type'] = 'application/json'
      ..body = '{"key":"item-key","extra":"not allowed"}';
    final client = http.Client();
    final malformedResult =
        await http.Response.fromStream(await client.send(malformed));
    final shapeResult =
        await http.Response.fromStream(await client.send(invalidShape));
    client.close();

    expect(malformedResult.statusCode, HttpStatus.badRequest);
    expect(shapeResult.statusCode, HttpStatus.badRequest);
    expect(upstreamCalls, isEmpty);
  });

  test('rejects cart routes with wrong methods and unknown routes', () async {
    final wrongMethod = await http.get(
      baseUri.replace(path: '/wp-json/wc/store/v1/cart/add-item'),
      headers: const {'Origin': 'http://localhost:5000'},
    );
    final unknownRoute = await http.post(
      baseUri.replace(path: '/wp-json/wc/store/v1/cart/clear'),
      headers: const {'Origin': 'http://localhost:5000'},
    );

    expect(wrongMethod.statusCode, HttpStatus.methodNotAllowed);
    expect(unknownRoute.statusCode, HttpStatus.notFound);
    expect(upstreamCalls, isEmpty);
  });
}
