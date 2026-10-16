import 'dart:async';
import 'dart:convert';

import 'package:elemshaty_pharmacy/backend/woocommerce/catalog_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

const _runLiveDiagnostic = bool.fromEnvironment(
  'RUN_WOOCOMMERCE_LIVE_DIAGNOSTIC',
  defaultValue: false,
);

const _catalogBaseUrl = String.fromEnvironment(
  'WOOCOMMERCE_BASE_URL',
  defaultValue: 'https://el-emshaty-pharmacy.com',
);

void main() {
  test(
    'live public products endpoint returns parseable catalog data',
    () async {
      final uri = Uri.parse(
        '${_catalogBaseUrl.replaceFirst(RegExp(r'/+$'), '')}'
        '/wp-json/wc/store/v1/products',
      ).replace(queryParameters: const {'per_page': '1'});

      http.Response response;
      try {
        response = await http.get(
          uri,
          headers: const {'Accept': 'application/json'},
        ).timeout(const Duration(seconds: 20));
      } on TimeoutException {
        // Do not print the URL or exception details from a failed request.
        // ignore: avoid_print
        print(
            '[WooCommerce live diagnostic] status=none parse=not-attempted failure=timeout');
        rethrow;
      } on http.ClientException catch (error) {
        // Runtime type is safe to report; exception text may include a URL.
        // ignore: avoid_print
        print(
          '[WooCommerce live diagnostic] status=none '
          'parse=not-attempted failure=${error.runtimeType}',
        );
        rethrow;
      } catch (error) {
        // Do not print exception text, which may contain request details.
        // ignore: avoid_print
        print(
          '[WooCommerce live diagnostic] status=none '
          'parse=not-attempted failure=${error.runtimeType}',
        );
        rethrow;
      }

      var parsedProductCount = 0;
      var parseResult = 'failed';
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          (response.headers['content-type'] ?? '')
              .toLowerCase()
              .contains('application/json')) {
        try {
          final decoded = jsonDecode(utf8.decode(response.bodyBytes));
          if (decoded is List) {
            final products = decoded
                .whereType<Map>()
                .map((item) => WooProduct.fromJson(
                      Map<String, dynamic>.from(item),
                    ))
                .toList(growable: false);
            parsedProductCount = products.length;
            parseResult = 'success';
          } else {
            parseResult = 'failed (expected a JSON list)';
          }
        } on FormatException {
          parseResult = 'failed (malformed JSON)';
        } catch (error) {
          parseResult = 'failed (${error.runtimeType})';
        }
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        parseResult = 'not attempted (non-JSON content type)';
      } else {
        parseResult = 'not attempted (HTTP error)';
      }

      // Report only status and parsing outcome; omit product data and URL.
      // ignore: avoid_print
      print(
        '[WooCommerce live diagnostic] status=${response.statusCode} '
        'parse=$parseResult productCount=$parsedProductCount',
      );
      expect(response.statusCode, 200);
      expect(parseResult, 'success');
      expect(parsedProductCount, greaterThan(0));
    },
    skip: !_runLiveDiagnostic,
  );
}
