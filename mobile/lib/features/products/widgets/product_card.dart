import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image placeholder — warm gradient
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primarySurface.withOpacity(0.5),
                    AppColors.accentLight.withOpacity(0.4),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimens.radiusMd),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.eco_outlined,
                  size: 36,
                  color: AppColors.primaryLight,
                ),
              ),
            ),

            // Product info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppDimens.md, AppDimens.sm + 2, AppDimens.md, AppDimens.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),

                    // Category
                    if (product.subCategory != null || product.category != null)
                      Text(
                        product.subCategory?.title ??
                            product.category?.title ??
                            '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textHint,
                              fontSize: 11,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const Spacer(),

                    // Price and stock
                    Row(
                      children: [
                        // Price
                        if (product.firstPrice != null)
                          Expanded(
                            child: Text(
                              product.firstPrice!.displayPrice,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        // Stock badge
                        if (!product.inStock)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.08),
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusFull),
                            ),
                            child: Text(
                              'Sold out',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
