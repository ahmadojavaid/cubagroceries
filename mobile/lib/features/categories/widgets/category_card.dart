import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../data/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category image — larger, circular
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primarySurface.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: AppNetworkImage(
                      imageUrl: category.image,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorWidget: _imageFallback(),
                    ),
            ),
            const SizedBox(height: AppDimens.sm + 2),
            // Category title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.sm),
              child: Text(
                category.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      width: 72,
      height: 72,
      color: AppColors.primarySurface.withValues(alpha: 0.4),
      child: Icon(
        Icons.eco_outlined,
        size: 30,
        color: AppColors.primaryLight,
      ),
    );
  }
}
