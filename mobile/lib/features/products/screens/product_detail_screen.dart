import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
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
        error: (e, _) => ErrorStateWidget(
          message: 'Failed to load product details',
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
        data: (product) {
          if (product == null) {
            return const EmptyStateWidget(
              icon: Icons.search_off_rounded,
              message: 'Product not found',
            );
          }
          return _buildContent(context, product);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, product) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image hero — full width, warm gradient
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primarySurface.withOpacity(0.6),
                  AppColors.accentLight.withOpacity(0.5),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.eco_outlined,
                size: 72,
                color: AppColors.primaryLight,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppDimens.sm),

                // Category breadcrumb
                if (product.category != null)
                  Text(
                    [
                      product.category?.title,
                      product.subCategory?.title,
                    ].where((t) => t != null).join(' › '),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.textHint),
                  ),
                const SizedBox(height: AppDimens.md),

                // Stock badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: product.inStock
                        ? AppColors.success.withOpacity(0.08)
                        : AppColors.error.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  ),
                  child: Text(
                    product.inStock
                        ? 'In Stock (${product.stock})'
                        : 'Out of Stock',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: product.inStock
                              ? AppColors.success
                              : AppColors.error,
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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppDimens.sm),
                  Text(
                    product.description!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: AppDimens.lg),
                ],

                // Prices
                Text(
                  'Available Prices',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppDimens.md),

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

                const SizedBox(height: AppDimens.xl),

                // Add to cart
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: product.inStock ? () {} : null,
                    icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppDimens.md),
                      disabledBackgroundColor: AppColors.border,
                      disabledForegroundColor: AppColors.textHint,
                    ),
                  ),
                ),

                const SizedBox(height: AppDimens.lg),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, PriceModel price) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.sm),
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.md, vertical: AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
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
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    price.unit.abbreviation!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textHint,
                        ),
                  ),
                ),
            ],
          ),
          Text(
            'Rs ${price.price}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
          ),
        ],
      ),
    );
  }
}
