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
      body: _buildBody(context, catState, children, parent),
    );
  }

  Widget _buildBody(
    BuildContext context,
    CategoriesState state,
    List<CategoryModel> children,
    CategoryModel? parent,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (children.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(parent?.title ?? 'Category')),
        body: EmptyStateWidget(
          icon: Icons.folder_open_outlined,
          message: 'No sub-categories found',
          actionLabel: 'View all products',
          onAction: () => context.push('/categories/$categoryId/products'),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        // Collapsing header with category image
        SliverAppBar(
          expandedHeight: parent?.image != null ? 200 : 0,
          floating: false,
          pinned: true,
          flexibleSpace: parent?.image != null
              ? FlexibleSpaceBar(
                  title: Text(
                    parent!.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      shadows: [
                        Shadow(color: Colors.black54, blurRadius: 12),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppNetworkImage(
                        imageUrl: parent.image,
                        fit: BoxFit.cover,
                      ),
                      // Dark gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          title: parent?.image == null
              ? Text(parent?.title ?? 'Category')
              : null,
        ),

        // "Browse all" card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.pagePadding,
              AppDimens.lg,
              AppDimens.pagePadding,
              4,
            ),
            child: GestureDetector(
              onTap: () => context.push('/categories/$categoryId/products'),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.85),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.grid_view_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Browse All Products',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'View everything in ${parent?.title ?? 'this category'}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Section header with count
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.pagePadding,
              AppDimens.lg + 4,
              AppDimens.pagePadding,
              AppDimens.md,
            ),
            child: Row(
              children: [
                Text(
                  'Sub-categories',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                  ),
                  child: Text(
                    '${children.length}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Sub-category list — horizontal image cards
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.pagePadding,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final subCat = children[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.sm + 2),
                  child: _SubCategoryCard(
                    category: subCat,
                    onTap: () => context.push(
                      '/categories/$categoryId/products',
                      extra: {'sub_category_id': subCat.id},
                    ),
                  ),
                );
              },
              childCount: children.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppDimens.xl),
        ),
      ],
    );
  }
}

/// Horizontal card — image on left, title + arrow on right
class _SubCategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const _SubCategoryCard({
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
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(color: AppColors.border.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.radiusLg),
                  bottomLeft: Radius.circular(AppDimens.radiusLg),
                ),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: AppNetworkImage(
                    imageUrl: category.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      color: AppColors.primarySurface,
                      child: const Icon(Icons.category_rounded,
                          color: AppColors.primary, size: 28),
                    ),
                  ),
                ),
              ),
              // Title
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Arrow
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
