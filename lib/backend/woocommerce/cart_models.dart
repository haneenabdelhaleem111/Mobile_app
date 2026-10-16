/// Typed, tolerant models for the WooCommerce Store API cart response.
/// Monetary values are converted from Store API minor-unit strings into
/// decimal amounts using the currency's `currency_minor_unit` value.
class WooCart {
  const WooCart({
    required this.items,
    required this.itemsCount,
    required this.itemsWeight,
    required this.needsPayment,
    required this.needsShipping,
    required this.hasCalculatedShipping,
    required this.totals,
  });

  final List<WooCartItem> items;
  final int itemsCount;
  final num itemsWeight;
  final bool needsPayment;
  final bool needsShipping;
  final bool hasCalculatedShipping;
  final WooCartTotals totals;

  factory WooCart.fromJson(Map<String, dynamic> json) => WooCart(
        items: json['items'] is List
            ? (json['items'] as List)
                .whereType<Map>()
                .map((item) => WooCartItem.fromJson(
                      Map<String, dynamic>.from(item),
                    ))
                .toList(growable: false)
            : const [],
        itemsCount: _cartInt(json['items_count']),
        itemsWeight: _cartNum(json['items_weight']),
        needsPayment: json['needs_payment'] == true,
        needsShipping: json['needs_shipping'] == true,
        hasCalculatedShipping: json['has_calculated_shipping'] == true,
        totals: WooCartTotals.fromJson(
          json['totals'] is Map
              ? Map<String, dynamic>.from(json['totals'] as Map)
              : const {},
        ),
      );
}

class WooCartItem {
  const WooCartItem({
    required this.key,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.name,
    required this.sku,
    required this.permalink,
    required this.images,
    required this.variation,
    required this.prices,
    required this.totals,
  });

  final String key;
  final int productId;
  final int? variationId;
  final int quantity;
  final String name;
  final String sku;
  final String permalink;
  final List<String> images;
  final List<WooCartVariation> variation;
  final WooCartPrices prices;
  final WooCartItemTotals totals;

  factory WooCartItem.fromJson(Map<String, dynamic> json) {
    final rawVariation = json['variation'];
    final variation = rawVariation is List
        ? rawVariation
            .whereType<Map>()
            .map((entry) => WooCartVariation.fromJson(
                  Map<String, dynamic>.from(entry),
                ))
            .toList(growable: false)
        : const <WooCartVariation>[];
    final rawImages = json['images'];

    return WooCartItem(
      key: _cartString(json['key']),
      productId: _cartInt(json['product_id'] ?? json['id']),
      variationId: _cartNullableInt(json['variation_id']),
      quantity: _cartInt(json['quantity']),
      name: _cartString(json['name']),
      sku: _cartString(json['sku']),
      permalink: _cartString(json['permalink']),
      images: rawImages is List
          ? rawImages
              .whereType<Map>()
              .map((image) => _cartString(image['src']))
              .where((src) => src.isNotEmpty)
              .toList(growable: false)
          : const [],
      variation: variation,
      prices: WooCartPrices.fromJson(
        json['prices'] is Map
            ? Map<String, dynamic>.from(json['prices'] as Map)
            : const {},
      ),
      totals: WooCartItemTotals.fromJson(
        json['totals'] is Map
            ? Map<String, dynamic>.from(json['totals'] as Map)
            : const {},
      ),
    );
  }
}

class WooCartVariation {
  const WooCartVariation({required this.attribute, required this.value});

  final String attribute;
  final String value;

  factory WooCartVariation.fromJson(Map<String, dynamic> json) =>
      WooCartVariation(
        attribute: _cartString(json['attribute']),
        value: _cartString(json['value']),
      );
}

class WooCartPrices {
  const WooCartPrices({
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
  });

  final num? price;
  final num? regularPrice;
  final num? salePrice;
  final String currencyCode;
  final String currencySymbol;
  final int currencyMinorUnit;

  factory WooCartPrices.fromJson(Map<String, dynamic> json) {
    final minorUnit = _cartInt(json['currency_minor_unit'], fallback: 2);
    return WooCartPrices(
      price: _cartMoney(json['price'], minorUnit),
      regularPrice: _cartMoney(json['regular_price'], minorUnit),
      salePrice: _cartMoney(json['sale_price'], minorUnit),
      currencyCode: _cartString(json['currency_code']),
      currencySymbol: _cartString(json['currency_symbol']),
      currencyMinorUnit: minorUnit,
    );
  }
}

class WooCartItemTotals {
  const WooCartItemTotals({
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTotalTax,
  });

  final num? lineSubtotal;
  final num? lineSubtotalTax;
  final num? lineTotal;
  final num? lineTotalTax;

  factory WooCartItemTotals.fromJson(Map<String, dynamic> json) {
    final minorUnit = _cartInt(json['currency_minor_unit'], fallback: 2);
    return WooCartItemTotals(
      lineSubtotal: _cartMoney(json['line_subtotal'], minorUnit),
      lineSubtotalTax: _cartMoney(json['line_subtotal_tax'], minorUnit),
      lineTotal: _cartMoney(json['line_total'], minorUnit),
      lineTotalTax: _cartMoney(json['line_total_tax'], minorUnit),
    );
  }
}

class WooCartTotals {
  const WooCartTotals({
    required this.totalItems,
    required this.totalItemsTax,
    required this.totalFees,
    required this.totalFeesTax,
    required this.totalDiscount,
    required this.totalDiscountTax,
    required this.totalShipping,
    required this.totalShippingTax,
    required this.totalPrice,
    required this.taxLines,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
  });

  final num? totalItems;
  final num? totalItemsTax;
  final num? totalFees;
  final num? totalFeesTax;
  final num? totalDiscount;
  final num? totalDiscountTax;
  final num? totalShipping;
  final num? totalShippingTax;
  final num? totalPrice;
  final List<WooCartTaxLine> taxLines;
  final String currencyCode;
  final String currencySymbol;
  final int currencyMinorUnit;

  factory WooCartTotals.fromJson(Map<String, dynamic> json) {
    final minorUnit = _cartInt(json['currency_minor_unit'], fallback: 2);
    final rawTaxLines = json['tax_lines'];
    return WooCartTotals(
      totalItems: _cartMoney(json['total_items'], minorUnit),
      totalItemsTax: _cartMoney(json['total_items_tax'], minorUnit),
      totalFees: _cartMoney(json['total_fees'], minorUnit),
      totalFeesTax: _cartMoney(json['total_fees_tax'], minorUnit),
      totalDiscount: _cartMoney(json['total_discount'], minorUnit),
      totalDiscountTax: _cartMoney(json['total_discount_tax'], minorUnit),
      totalShipping: _cartMoney(json['total_shipping'], minorUnit),
      totalShippingTax: _cartMoney(json['total_shipping_tax'], minorUnit),
      totalPrice: _cartMoney(json['total_price'], minorUnit),
      taxLines: rawTaxLines is List
          ? rawTaxLines
              .whereType<Map>()
              .map((line) => WooCartTaxLine.fromJson(
                    Map<String, dynamic>.from(line),
                    minorUnit: minorUnit,
                  ))
              .toList(growable: false)
          : const [],
      currencyCode: _cartString(json['currency_code']),
      currencySymbol: _cartString(json['currency_symbol']),
      currencyMinorUnit: minorUnit,
    );
  }
}

class WooCartTaxLine {
  const WooCartTaxLine({
    required this.name,
    required this.price,
    required this.rate,
  });

  final String name;
  final num? price;
  final String rate;

  factory WooCartTaxLine.fromJson(Map<String, dynamic> json,
          {required int minorUnit}) =>
      WooCartTaxLine(
        name: _cartString(json['name']),
        price: _cartMoney(json['price'], minorUnit),
        rate: _cartString(json['rate']),
      );
}

String _cartString(dynamic value) => value == null ? '' : value.toString();

int _cartInt(dynamic value, {int fallback = 0}) =>
    value is int ? value : int.tryParse(_cartString(value)) ?? fallback;

int? _cartNullableInt(dynamic value) =>
    value == null ? null : int.tryParse(_cartString(value));

num _cartNum(dynamic value) =>
    value is num ? value : num.tryParse(_cartString(value)) ?? 0;

num? _cartMoney(dynamic value, int minorUnit) {
  if (value == null || value == '') return null;
  final amount = num.tryParse(_cartString(value));
  if (amount == null) return null;
  var divisor = 1;
  for (var i = 0; i < minorUnit.clamp(0, 6); i++) {
    divisor *= 10;
  }
  return amount / divisor;
}
