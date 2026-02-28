import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/price_model.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _buildError(context, ref),
        data: (product) {
          if (product == null) return _buildNotFound(context);
          return _buildContent(context, product);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: Center(
              child: Icon(
                Icons.inventory_2_outlined,
                size: 64,
                color: AppColors.primary.withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.md),

          // Name
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: AppDimens.sm),

          // Category breadcrumb
          if (product.category != null)
            Row(
              children: [
                const Icon(Icons.folder_outlined,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: AppDimens.xs),
                Text(
                  [
                    product.category?.title,
                    product.subCategory?.title,
                  ].where((t) => t != null).join(' › '),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          const SizedBox(height: AppDimens.sm),

          // Stock indicator
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.sm,
              vertical: AppDimens.xs,
            ),
            decoration: BoxDecoration(
              color: product.inStock
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Text(
              product.inStock
                  ? 'In Stock (${product.stock})'
                  : 'Out of Stock',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        product.inStock ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: AppDimens.lg),

          // Description
          if (product.description != null &&
              product.description!.isNotEmpty) ...[
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: AppDimens.sm),
            Text(
              product.description!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: AppDimens.lg),
          ],

          // Prices
          Text(
            'Available Prices',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: AppDimens.sm),

          if (product.prices.isEmpty)
            Text(
              'No prices available',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textHint),
            )
          else
            ...product.prices.map<Widget>(
              (PriceModel price) => _buildPriceRow(context, price),
            ),

          const SizedBox(height: AppDimens.lg),

          // Add to cart button (non-functional placeholder)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: product.inStock ? () {} : null,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                disabledBackgroundColor: AppColors.border,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, PriceModel price) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.sm),
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Per ${price.unit.name}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              if (price.unit.abbreviation != null)
                Text(
                  price.unit.abbreviation!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textHint,
                      ),
                ),
            ],
          ),
          Text(
            'Rs ${price.price}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppDimens.md),
            Text(
              'Failed to load product details',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppDimens.md),
            ElevatedButton(
              onPressed: () => ref.invalidate(productDetailProvider(productId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          Text(
            'Product not found',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
