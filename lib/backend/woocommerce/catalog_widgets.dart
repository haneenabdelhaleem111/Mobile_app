import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/products/product_details/product_details_widget.dart';
import '/pages/products_search/products_search_widget.dart';
import 'catalog_models.dart';
import 'woocommerce_cart_controller.dart';
import 'woocommerce_catalog_service.dart';

class WooCatalogProductsWidget extends StatefulWidget {
  const WooCatalogProductsWidget({
    super.key,
    this.search,
    this.categoryId,
    this.onSale = false,
    this.horizontal = false,
    this.perPage = 12,
  });

  final String? search;
  final int? categoryId;
  final bool onSale;
  final bool horizontal;
  final int perPage;

  @override
  State<WooCatalogProductsWidget> createState() =>
      _WooCatalogProductsWidgetState();
}

class _WooCatalogProductsWidgetState extends State<WooCatalogProductsWidget> {
  final List<WooProduct> _products = [];
  int _page = 1;
  int _totalPages = 1;
  int _requestVersion = 0;
  Timer? _searchDebounce;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant WooCatalogProductsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.search != widget.search ||
        oldWidget.categoryId != widget.categoryId ||
        oldWidget.onSale != widget.onSale) {
      _products.clear();
      _page = 1;
      _totalPages = 1;
      _loading = true;
      _loadingMore = false;
      _error = null;
      _requestVersion++;
      _searchDebounce?.cancel();
      _searchDebounce = Timer(const Duration(milliseconds: 350), _load);
    }
  }

  Future<void> _load({bool append = false}) async {
    final requestVersion = ++_requestVersion;
    if (append) {
      if (_loadingMore || _page >= _totalPages) return;
      setState(() => _loadingMore = true);
    } else {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    try {
      final nextPage = append ? _page + 1 : 1;
      final result = await WooCommerceCatalogService.instance.getProducts(
        page: nextPage,
        perPage: widget.perPage,
        search: widget.search,
        categoryId: widget.categoryId,
        onSale: widget.onSale,
      );
      if (!mounted || requestVersion != _requestVersion) return;
      setState(() {
        if (!append) _products.clear();
        _products.addAll(result.items);
        _page = result.page;
        _totalPages = result.totalPages;
        _loading = false;
        _loadingMore = false;
      });
    } catch (error) {
      if (!mounted || requestVersion != _requestVersion) return;
      setState(() {
        _error = error.toString();
        _loading = false;
        _loadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return _MessageState(
        icon: Icons.cloud_off_outlined,
        message: _error!,
        actionLabel: 'Retry',
        onPressed: _load,
      );
    }
    if (_products.isEmpty) {
      return const _MessageState(
        icon: Icons.search_off_rounded,
        message: 'No products found.',
      );
    }

    if (widget.horizontal) {
      return SizedBox(
        height: 274,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _products.length + (_page < _totalPages ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            if (index == _products.length) {
              return Center(
                child: TextButton(
                  onPressed: _loadingMore ? null : () => _load(append: true),
                  child: const Text('Load more'),
                ),
              );
            }
            return SizedBox(
              width: 180,
              child: WooCatalogProductCard(product: _products[index]),
            );
          },
        ),
      );
    }

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth < 480 ? 2 : 3;
            final itemWidth =
                (constraints.maxWidth - (columns - 1) * 12) / columns;
            final itemHeight = itemWidth * 1.42;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: itemHeight.clamp(224, 330),
              ),
              itemBuilder: (context, index) =>
                  WooCatalogProductCard(product: _products[index]),
            );
          },
        ),
        if (_page < _totalPages)
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton(
              onPressed: _loadingMore ? null : () => _load(append: true),
              child: _loadingMore
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Load more products'),
            ),
          ),
      ],
    );
  }
}

class WooCatalogProductCard extends StatelessWidget {
  const WooCatalogProductCard({super.key, required this.product});

  final WooProduct product;

  void _open(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => ProductDetailsWidget(productId: product.id),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _open(context),
      child: Container(
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.alternate),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (product.imageUrl.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (_, __) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (_, __, ___) =>
                          const _ProductImagePlaceholder(),
                    )
                  else
                    const _ProductImagePlaceholder(),
                  if (product.isOnSale)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.error,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text('SALE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.labelLarge),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    children: [
                      Text(product.formatPrice(product.price),
                          style: TextStyle(
                              color: theme.primary,
                              fontWeight: FontWeight.w700)),
                      if (product.isOnSale && product.regularPrice != null)
                        Text(product.formatPrice(product.regularPrice),
                            style: TextStyle(
                              color: theme.secondaryText,
                              decoration: TextDecoration.lineThrough,
                            )),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(product.isInStock ? 'In stock' : 'Out of stock',
                      style: TextStyle(
                        fontSize: 12,
                        color: product.isInStock ? theme.success : theme.error,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WooCatalogCategoriesWidget extends StatefulWidget {
  const WooCatalogCategoriesWidget({super.key});

  @override
  State<WooCatalogCategoriesWidget> createState() =>
      _WooCatalogCategoriesWidgetState();
}

class _WooCatalogCategoriesWidgetState
    extends State<WooCatalogCategoriesWidget> {
  late Future<WooCatalogPage<WooProductCategory>> _future;

  @override
  void initState() {
    super.initState();
    _future = WooCommerceCatalogService.instance.getCategories();
  }

  void _retry() => setState(() {
        WooCommerceCatalogService.instance.clearCache();
        _future = WooCommerceCatalogService.instance.getCategories();
      });

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<WooCatalogPage<WooProductCategory>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return _MessageState(
              icon: Icons.cloud_off_outlined,
              message: snapshot.error.toString(),
              actionLabel: 'Retry',
              onPressed: _retry,
            );
          }
          final categories = snapshot.data?.items ?? const [];
          if (categories.isEmpty) {
            return const _MessageState(
              icon: Icons.category_outlined,
              message: 'No categories found.',
            );
          }
          return Column(
            children: categories
                .map((category) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: category.imageUrl == null
                              ? const CircleAvatar(
                                  child: Icon(Icons.category_outlined))
                              : CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      category.imageUrl!),
                                ),
                          title: Text(category.name),
                          subtitle: Text('${category.count} products'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => ProductsSearchWidget(
                                categoryId: category.id,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(growable: false),
          );
        },
      );
}

class WooCatalogCategoryFiltersWidget extends StatefulWidget {
  const WooCatalogCategoryFiltersWidget({
    super.key,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  final int? selectedCategoryId;
  final ValueChanged<int?> onSelected;

  @override
  State<WooCatalogCategoryFiltersWidget> createState() =>
      _WooCatalogCategoryFiltersWidgetState();
}

class _WooCatalogCategoryFiltersWidgetState
    extends State<WooCatalogCategoryFiltersWidget> {
  late Future<WooCatalogPage<WooProductCategory>> _future;

  @override
  void initState() {
    super.initState();
    _future = WooCommerceCatalogService.instance.getCategories(perPage: 30);
  }

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<WooCatalogPage<WooProductCategory>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 36,
              child: Center(child: LinearProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Row(
              children: [
                Text('Category filters unavailable',
                    style: FlutterFlowTheme.of(context).bodySmall),
                TextButton(
                  onPressed: () => setState(() {
                    WooCommerceCatalogService.instance.clearCache();
                    _future = WooCommerceCatalogService.instance
                        .getCategories(perPage: 30);
                  }),
                  child: const Text('Retry'),
                ),
              ],
            );
          }
          final categories = snapshot.data?.items ?? const [];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _categoryChip(context, 'All Products', null),
                for (final category in categories)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _categoryChip(context, category.name, category.id),
                  ),
              ],
            ),
          );
        },
      );

  Widget _categoryChip(BuildContext context, String label, int? categoryId) {
    final theme = FlutterFlowTheme.of(context);
    final selected = widget.selectedCategoryId == categoryId;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => widget.onSelected(categoryId),
      selectedColor: theme.primary,
      labelStyle: TextStyle(
        color: selected ? Colors.white : theme.primaryText,
      ),
      backgroundColor: theme.secondaryBackground,
      side: BorderSide(color: theme.alternate),
    );
  }
}

class WooCatalogProductDetailsWidget extends StatefulWidget {
  const WooCatalogProductDetailsWidget({
    super.key,
    required this.productId,
    this.cartController,
    this.loadProduct,
  });

  final int productId;
  final WooCommerceCartController? cartController;
  final Future<WooProduct> Function(int productId)? loadProduct;

  @override
  State<WooCatalogProductDetailsWidget> createState() =>
      _WooCatalogProductDetailsWidgetState();
}

class _WooCatalogProductDetailsWidgetState
    extends State<WooCatalogProductDetailsWidget> {
  late Future<WooProduct> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadProduct();
  }

  Future<WooProduct> _loadProduct() =>
      widget.loadProduct?.call(widget.productId) ??
      WooCommerceCatalogService.instance.getProduct(widget.productId);

  Future<void> _addToCart(WooProduct product) async {
    final controller =
        widget.cartController ?? WooCommerceCartController.instance;
    controller.clearError();
    await controller.addItem(productId: product.id);
    if (!mounted) return;
    final error = controller.errorMessage;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? 'Added to cart.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<WooProduct>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return _MessageState(
              icon: Icons.cloud_off_outlined,
              message: snapshot.error?.toString() ??
                  'Product details are unavailable.',
              actionLabel: 'Retry',
              onPressed: () => setState(() {
                WooCommerceCatalogService.instance.clearCache();
                _future = WooCommerceCatalogService.instance
                    .getProduct(widget.productId);
              }),
            );
          }
          final product = snapshot.data!;
          final theme = FlutterFlowTheme.of(context);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 320,
                  color: theme.alternate.withValues(alpha: .25),
                  child: product.imageUrl.isEmpty
                      ? const _ProductImagePlaceholder()
                      : CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) =>
                              const _ProductImagePlaceholder(),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: theme.headlineSmall),
                      if (product.categories.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(product.categories.join(' • '),
                            style: theme.bodySmall),
                      ],
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: [
                          Text(product.formatPrice(product.price),
                              style: TextStyle(
                                  color: theme.primary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          if (product.isOnSale && product.regularPrice != null)
                            Text(product.formatPrice(product.regularPrice),
                                style: TextStyle(
                                    color: theme.secondaryText,
                                    decoration: TextDecoration.lineThrough)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        !product.stockStatusKnown
                            ? 'Stock status unavailable'
                            : product.isInStock
                                ? 'In stock'
                                : 'Out of stock',
                        style: TextStyle(
                          color: !product.stockStatusKnown
                              ? theme.secondaryText
                              : product.isInStock
                                  ? theme.success
                                  : theme.error,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Product Description', style: theme.titleMedium),
                      const SizedBox(height: 8),
                      Text(_plainText(product.description.isEmpty
                          ? product.shortDescription
                          : product.description)),
                      const SizedBox(height: 24),
                      AnimatedBuilder(
                        animation: widget.cartController ??
                            WooCommerceCartController.instance,
                        builder: (context, _) {
                          final controller = widget.cartController ??
                              WooCommerceCartController.instance;
                          final isSupported = product.type == 'simple';
                          final canAdd = isSupported &&
                              product.stockStatusKnown &&
                              product.isInStock &&
                              !controller.isMutationInProgress &&
                              !controller.requiresRefresh;
                          final label = !product.isInStock
                              ? 'Out of stock'
                              : product.type == 'variable'
                                  ? 'Product options required'
                                  : isSupported
                                      ? 'Add to Cart'
                                      : 'Unavailable';
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FilledButton.icon(
                                onPressed:
                                    canAdd ? () => _addToCart(product) : null,
                                icon: controller.isMutationInProgress
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.shopping_cart_outlined),
                                label: Text(label),
                              ),
                              if (!isSupported && product.isInStock)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Adding this product type is not supported yet.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              if (controller.requiresRefresh)
                                TextButton(
                                  onPressed: controller.isLoading
                                      ? null
                                      : controller.refreshCart,
                                  child: const Text('Refresh cart to continue'),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class _ProductImagePlaceholder extends StatelessWidget {
  const _ProductImagePlaceholder();

  @override
  Widget build(BuildContext context) => Container(
        color: FlutterFlowTheme.of(context).alternate.withValues(alpha: .2),
        alignment: Alignment.center,
        child: Icon(Icons.medication_outlined,
            size: 44, color: FlutterFlowTheme.of(context).secondaryText),
      );
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onPressed,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 36, color: FlutterFlowTheme.of(context).secondaryText),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              if (actionLabel != null) ...[
                const SizedBox(height: 8),
                TextButton(onPressed: onPressed, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      );
}

String _plainText(String value) => value
    .replaceAll(RegExp(r'<[^>]*>'), ' ')
    .replaceAll('&nbsp;', ' ')
    .replaceAll('&amp;', '&')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();
