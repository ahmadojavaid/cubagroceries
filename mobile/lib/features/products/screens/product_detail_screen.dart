import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/fullscreen_image_viewer.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/price_model.dart';
import '../data/product_model.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/product_reviews_section.dart';
import '../../cart/data/cart_item_model.dart';
import '../../cart/providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _selectedPriceIndex = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productDetailProvider(widget.productId));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Scaffold(
          appBar: AppBar(),
          body: ErrorStateWidget(
            message: 'Failed to load product details',
            onRetry: () =>
                ref.invalidate(productDetailProvider(widget.productId)),
          ),
        ),
        data: (product) {
          if (product == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const EmptyStateWidget(
                icon: Icons.search_off_rounded,
                message: 'Product not found',
              ),
            );
          }
          return _buildPage(context, product);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, ProductModel product) {
    final selectedPrice =
        product.prices.isNotEmpty ? product.prices[_selectedPriceIndex] : null;

    return Stack(
      children: [
        // Scrollable content
        CustomScrollView(
          slivers: [
            // ── Image hero with overlaid back button ──
            SliverToBoxAdapter(child: _buildImageHero(context, product)),

            // ── Main content ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.pagePadding,
                AppDimens.lg,
                AppDimens.pagePadding,
                120, // space for bottom bar
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Name + category
                  _buildHeader(context, product),
                  const SizedBox(height: AppDimens.lg + 4),

                  // Price selector
                  if (product.prices.isNotEmpty) ...[
                    _buildPriceSelector(context, product),
                    const SizedBox(height: AppDimens.lg + 4),
                  ],

                  // Quantity selector
                  if (product.inStock && selectedPrice != null) ...[
                    _buildQuantitySelector(context),
                    const SizedBox(height: AppDimens.lg + 4),
                  ],

                  // Rating indicator
                  ProductRatingIndicator(
                    productId: widget.productId,
                    productName: product.name,
                  ),
                  const SizedBox(height: AppDimens.lg + 4),

                  // Description
                  if (product.description != null &&
                      product.description!.isNotEmpty) ...[
                    _buildDescription(context, product),
                    const SizedBox(height: AppDimens.lg + 4),
                  ],

                  // Related products
                  _RelatedProductsSection(productId: widget.productId),
                ]),
              ),
            ),
          ],
        ),

        // ── Sticky bottom bar ──
        if (product.inStock && selectedPrice != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(context, product, selectedPrice),
          ),

        // ── Out of stock overlay ──
        if (!product.inStock)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildOutOfStockBar(context),
          ),
      ],
    );
  }

  // ───────────── Image Hero ─────────────

  Widget _buildImageHero(BuildContext context, ProductModel product) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FullscreenImageViewer.open(
            context,
            imageUrl: product.image,
            heroTag: 'product_${product.id}',
          ),
          child: Container(
            height: 320,
            width: double.infinity,
            color: AppColors.cardBg,
            child: Hero(
              tag: 'product_${product.id}',
              child: AppNetworkImage(
                imageUrl: product.image,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Gradient fade at bottom
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.scaffoldBg.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 12,
          child: _circleButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        // Cart button (top right)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 12,
          child: _buildCartButton(context),
        ),
        // Stock badge (below cart button, only shows Out of Stock)
        if (!product.inStock)
          Positioned(
            top: MediaQuery.of(context).padding.top + 56,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
              ),
              child: const Text(
                'Out of Stock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCartButton(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final itemCount = cart.itemCount;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        _circleButton(
          icon: Icons.shopping_cart_outlined,
          onTap: () => context.push('/cart'),
        ),
        if (itemCount > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                itemCount > 99 ? '99+' : '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white.withOpacity(0.9),
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 22, color: AppColors.textPrimary),
        ),
      ),
    );
  }

  // ───────────── Header ─────────────

  Widget _buildHeader(BuildContext context, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category breadcrumb
        if (product.category != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              [product.category?.title, product.subCategory?.title]
                  .where((t) => t != null)
                  .join('  ›  '),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                letterSpacing: 0.2,
              ),
            ),
          ),
        // Name
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  // ───────────── Price Selector ─────────────

  Widget _buildPriceSelector(BuildContext context, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select variant',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimens.sm + 2),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(product.prices.length, (index) {
            final price = product.prices[index];
            final isSelected = _selectedPriceIndex == index;
            return _PriceChip(
              price: price,
              isSelected: isSelected,
              onTap: () => setState(() {
                _selectedPriceIndex = index;
                _quantity = 1;
              }),
            );
          }),
        ),
      ],
    );
  }

  // ───────────── Quantity Selector ─────────────

  Widget _buildQuantitySelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag_outlined,
              size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          const Text(
            'Quantity',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          _quantityButton(
            icon: Icons.remove_rounded,
            onTap: _quantity > 1 ? () => setState(() => _quantity--) : null,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 44),
            alignment: Alignment.center,
            child: Text(
              '$_quantity',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _quantityButton(
            icon: Icons.add_rounded,
            onTap: () => setState(() => _quantity++),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({required IconData icon, VoidCallback? onTap}) {
    final enabled = onTap != null;
    return Material(
      color: enabled
          ? AppColors.primary.withOpacity(0.1)
          : AppColors.surfaceBg,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 20,
            color: enabled ? AppColors.primary : AppColors.textHint,
          ),
        ),
      ),
    );
  }

  // ───────────── Description ─────────────

  Widget _buildDescription(BuildContext context, ProductModel product) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About this product',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            product.description!,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────── Bottom Bar ─────────────

  Widget _buildBottomBar(
      BuildContext context, ProductModel product, PriceModel selectedPrice) {
    final lineTotal = selectedPrice.priceValue * _quantity;
    final cart = ref.watch(cartProvider);
    final existingQty = cart.items
        .where((e) =>
            e.productId == product.id && e.unitId == selectedPrice.unit.id)
        .fold(0, (sum, e) => sum + e.quantity);

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        14,
        AppDimens.pagePadding,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rs ${lineTotal.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${selectedPrice.unit.name} × $_quantity${existingQty > 0 ? '  •  $existingQty in cart' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimens.md),
          // Add to cart button
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => _addToCart(product, selectedPrice),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.add_shopping_cart_rounded, size: 20),
              label: Text(
                existingQty > 0 ? 'Add More' : 'Add to Cart',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutOfStockBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        14,
        AppDimens.pagePadding,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.border,
            disabledForegroundColor: AppColors.textHint,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Currently Unavailable',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
      ),
    );
  }

  void _addToCart(ProductModel product, PriceModel price) {
    ref.read(cartProvider.notifier).addItem(
          CartItemModel(
            productId: product.id,
            productName: product.name,
            unitId: price.unit.id,
            unitName: price.unit.name,
            price: price.priceValue,
            quantity: _quantity,
          ),
        );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_quantity × ${product.name} (${price.unit.name}) added to cart',
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () => context.push('/cart'),
        ),
      ),
    );

    setState(() => _quantity = 1);
  }
}

// ───────────── Price Chip Widget ─────────────

class _PriceChip extends StatelessWidget {
  final PriceModel price;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriceChip({
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primary : AppColors.cardBg,
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      elevation: isSelected ? 2 : 0,
      shadowColor: AppColors.primary.withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        child: Container(
          constraints: const BoxConstraints(minWidth: 100),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Rs ${price.price}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'per ${price.unit.name}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Colors.white.withOpacity(0.85)
                      : AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────── Related Products ─────────────

class _RelatedProductsSection extends ConsumerWidget {
  final int productId;

  const _RelatedProductsSection({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatedAsync = ref.watch(relatedProductsProvider(productId));

    return relatedAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (products) {
        if (products.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'You might also like',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimens.md),
            SizedBox(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppDimens.sm + 2),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return SizedBox(
                    width: 160,
                    child: ProductCard(
                      product: product,
                      onTap: () => context.push('/products/${product.id}'),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
