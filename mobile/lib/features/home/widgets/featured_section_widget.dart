import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../products/widgets/product_card.dart';
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
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
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
                onTap: () {
                  if (section.category.isSubCategory) {
                    // Sub-category: go directly to products filtered by sub_category
                    context.push(
                      '/categories/${section.category.parentId}/products',
                      extra: {'sub_category_id': section.category.id},
                    );
                  } else {
                    // Top-level: go to products for the category
                    context.push('/categories/${section.category.id}/products');
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.sm + 2),

        // Horizontal product cards — using shared ProductCard
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding),
            itemCount: section.products.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppDimens.sm + 2),
            itemBuilder: (context, index) {
              final product = section.products[index];
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
  }
}
