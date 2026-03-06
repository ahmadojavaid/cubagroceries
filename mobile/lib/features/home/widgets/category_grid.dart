import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../categories/data/category_model.dart';

/// Displays top-level categories in a 4-column grid.
class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onTap;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: AppDimens.md,
          crossAxisSpacing: AppDimens.sm,
          childAspectRatio: 0.78, // width / height — icon + label
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return _CategoryTile(category: cat, onTap: () => onTap(cat));
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _CategoryTile({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Icon container
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primarySurface.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                clipBehavior: Clip.antiAlias,
                child: AppNetworkImage(
                  imageUrl: category.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: _fallbackIcon(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Label
          Text(
            category.title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _fallbackIcon() {
    return Container(
      color: AppColors.primarySurface.withValues(alpha: 0.4),
      child: const Icon(
        Icons.eco_outlined,
        size: 28,
        color: AppColors.primaryLight,
      ),
    );
  }
}
