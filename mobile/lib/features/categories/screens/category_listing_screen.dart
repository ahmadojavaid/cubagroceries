import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/category_provider.dart';
import '../data/category_model.dart';

class CategoryListingScreen extends ConsumerWidget {
  final int categoryId;

  const CategoryListingScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catState = ref.watch(categoriesProvider);
    final parent = ref.read(categoriesProvider.notifier).findById(categoryId);
    final children =
        ref.read(categoriesProvider.notifier).getChildren(categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(parent?.title ?? 'Category'),
      ),
      body: _buildBody(context, catState, children),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CategoriesState state,
    List<CategoryModel> children,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (children.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.folder_open_outlined,
        message: 'No sub-categories found',
        actionLabel: 'View all products',
        onAction: () => context.push('/categories/$categoryId/products'),
      );
    }

    return CustomScrollView(
      slivers: [
        // "View all" banner at top
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.pagePadding,
              AppDimens.md,
              AppDimens.pagePadding,
              AppDimens.sm,
            ),
            child: Material(
              color: AppColors.primarySurface.withOpacity(0.4),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              child: InkWell(
                onTap: () =>
                    context.push('/categories/$categoryId/products'),
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.md,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.grid_view_rounded,
                        size: 20,
                        color: AppColors.primary.withOpacity(0.8),
                      ),
                      const SizedBox(width: AppDimens.sm + 2),
                      Expanded(
                        child: Text(
                          'View all products',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: AppColors.primary.withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Section header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.pagePadding,
              AppDimens.md,
              AppDimens.pagePadding,
              AppDimens.sm,
            ),
            child: Text(
              'Sub-categories',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),

        // Sub-category grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.pagePadding,
          ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimens.md,
              mainAxisSpacing: AppDimens.md,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final subCat = children[index];
                return _SubCategoryGridCard(
                  category: subCat,
                  onTap: () => context.push(
                    '/categories/$categoryId/products',
                    extra: {'sub_category_id': subCat.id},
                  ),
                );
              },
              childCount: children.length,
            ),
          ),
        ),

        // Bottom spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimens.xl),
        ),
      ],
    );
  }
}

/// Grid card for sub-categories — bigger image, clean layout
class _SubCategoryGridCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _SubCategoryGridCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(
              color: AppColors.border.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rounded image container
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
                clipBehavior: Clip.antiAlias,
                child: AppNetworkImage(
                  imageUrl: category.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorWidget: const ImageFallback(size: 80),
                ),
              ),
              const SizedBox(height: AppDimens.sm + 4),
              // Title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.sm + 2),
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
      ),
    );
  }
}
