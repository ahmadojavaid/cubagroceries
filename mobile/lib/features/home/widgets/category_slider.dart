import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../categories/data/category_model.dart';

class CategorySlider extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onTap;

  const CategorySlider({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppDimens.md),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return _CategoryChip(category: cat, onTap: () => onTap(cat));
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _CategoryChip({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primarySurface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              clipBehavior: Clip.antiAlias,
              child: AppNetworkImage(
                      imageUrl: category.image,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorWidget: _fallbackIcon(),
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackIcon() {
    return Container(
      color: AppColors.primarySurface.withOpacity(0.4),
      child: const Icon(Icons.eco_outlined, size: 28, color: AppColors.primaryLight),
    );
  }
}
