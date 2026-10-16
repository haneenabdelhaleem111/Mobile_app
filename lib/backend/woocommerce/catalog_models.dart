class WooCatalogPage<T> {
  const WooCatalogPage(
      {required this.items, required this.page, required this.totalPages});

  final List<T> items;
  final int page;
  final int totalPages;

  bool get hasMore => page < totalPages;
}

class WooProductCategory {
  const WooProductCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.count,
    this.imageUrl,
  });

  final int id;
  final String name;
  final String slug;
  final int parent;
  final int count;
  final String? imageUrl;

  factory WooProductCategory.fromJson(Map<String, dynamic> json) {
    final image = json['image'];
    return WooProductCategory(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      parent: _asInt(json['parent']),
      count: _asInt(json['count']),
      imageUrl: image is Map ? _nonEmpty(image['src']) : null,
    );
  }
}

class WooProductImage {
  const WooProductImage({required this.src, this.name = ''});

  final String src;
  final String name;

  factory WooProductImage.fromJson(Map<String, dynamic> json) =>
      WooProductImage(
        src: _asString(json['src']),
        name: _asString(json['name']),
      );
}

class WooProduct {
  const WooProduct({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.description,
    required this.shortDescription,
    required this.images,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.stockStatus,
    required this.isInStock,
    this.stockStatusKnown = false,
    required this.isOnSale,
    required this.categories,
    this.type = '',
  });

  final int id;
  final String name;
  final String slug;
  final String permalink;
  final String description;
  final String shortDescription;
  final List<WooProductImage> images;
  final num? price;
  final num? regularPrice;
  final num? salePrice;
  final String currencyCode;
  final String currencySymbol;
  final int currencyMinorUnit;
  final String stockStatus;
  final bool isInStock;
  final bool stockStatusKnown;
  final bool isOnSale;
  final List<String> categories;

  /// WooCommerce product type, for example `simple` or `variable`.
  final String type;

  String get imageUrl => images.isEmpty ? '' : images.first.src;

  String formatPrice(num? amount) {
    if (amount == null) return '';
    final digits = currencyMinorUnit.clamp(0, 4).toInt();
    final currency = currencySymbol.isEmpty ? currencyCode : currencySymbol;
    return '${currency.isEmpty ? '' : '$currency '}${amount.toStringAsFixed(digits)}';
  }

  factory WooProduct.fromJson(Map<String, dynamic> json) {
    final prices = json['prices'] is Map ? json['prices'] as Map : const {};
    final imagesJson = json['images'];
    final categoriesJson = json['categories'];
    final minorUnit = _asInt(prices['currency_minor_unit'], fallback: 2);
    final currentPrice = _parsePrice(prices['price'], minorUnit) ??
        _parsePrice(json['price'], 0);
    final regularPrice = _parsePrice(prices['regular_price'], minorUnit) ??
        _parsePrice(json['regular_price'], 0);
    final salePrice = _parsePrice(prices['sale_price'], minorUnit) ??
        _parsePrice(json['sale_price'], 0);
    final stockStatus = _asString(json['stock_status']);
    final isInStock = json['is_in_stock'] is bool
        ? json['is_in_stock'] as bool
        : stockStatus != 'outofstock';

    return WooProduct(
      id: _asInt(json['id']),
      name: _asString(json['name']),
      slug: _asString(json['slug']),
      permalink: _asString(json['permalink']),
      description: _asString(json['description']),
      shortDescription: _asString(json['short_description']),
      images: imagesJson is List
          ? imagesJson
              .whereType<Map>()
              .map((item) => WooProductImage.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .where((image) => image.src.isNotEmpty)
              .toList(growable: false)
          : const [],
      price: currentPrice,
      regularPrice: regularPrice,
      salePrice: salePrice,
      currencyCode: _asString(prices['currency_code']),
      currencySymbol: _asString(prices['currency_symbol']),
      currencyMinorUnit: minorUnit,
      stockStatus: stockStatus,
      isInStock: isInStock,
      stockStatusKnown: json['is_in_stock'] is bool || stockStatus.isNotEmpty,
      isOnSale: json['on_sale'] == true ||
          (salePrice != null &&
              regularPrice != null &&
              salePrice < regularPrice),
      categories: categoriesJson is List
          ? categoriesJson
              .whereType<Map>()
              .map((item) => _asString(item['name']))
              .where((name) => name.isNotEmpty)
              .toList(growable: false)
          : const [],
      type: _asString(json['type']),
    );
  }
}

String _asString(dynamic value) => value == null ? '' : value.toString();

String? _nonEmpty(dynamic value) {
  final string = _asString(value).trim();
  return string.isEmpty ? null : string;
}

int _asInt(dynamic value, {int fallback = 0}) =>
    value is int ? value : int.tryParse(_asString(value)) ?? fallback;

num? _parsePrice(dynamic value, int minorUnit) {
  if (value == null || value == '') return null;
  final parsed = num.tryParse(value.toString());
  if (parsed == null) return null;
  return minorUnit > 0 ? parsed / _pow10(minorUnit) : parsed;
}

num _pow10(int exponent) {
  var result = 1;
  for (var index = 0; index < exponent; index++) {
    result *= 10;
  }
  return result;
}
