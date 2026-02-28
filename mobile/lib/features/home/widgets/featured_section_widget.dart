import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../products/data/product_model.dart';
import '../data/featured_section_model.dart';

class FeaturedSectionWidget extends StatelessWidget {
  final FeaturedSection section;

  const FeaturedSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  section.category.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.push(
                  '/categories/${section.category.id}/products',
                ),
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.sm),

        // Horizontal product cards
        SizedBox(
          height: 195,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding),
            itemCount: section.products.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppDimens.sm),
            itemBuilder: (context, index) {
              return _ProductCard(product: section.products[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final price = product.firstPrice;

    return GestureDetector(
      onTap: () => context.push('/products/${product.id}'),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppDimens.radiusMd),
              ),
              child: AppNetworkImage(
                      imageUrl: product.image,
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Price
            if (price != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 0),
                child: Text(
                  'PKR ${price.price}/${price.unit.label}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            const Spacer(),

            // Add button
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SizedBox(
                width: double.infinity,
                height: 32,
                child: ElevatedButton(
                  onPressed: () => context.push('/products/${product.id}'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
