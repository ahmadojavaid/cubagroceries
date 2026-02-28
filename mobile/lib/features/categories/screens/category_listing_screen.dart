import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../providers/category_provider.dart';
import '../widgets/category_card.dart';

/// Shows sub-categories for a given parent category.
/// If the category has no children, redirects to products.
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
    List children,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (children.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open_outlined,
                size: 48, color: AppColors.textHint),
            const SizedBox(height: AppDimens.md),
            Text(
              'No sub-categories found',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppDimens.md),
            ElevatedButton(
              onPressed: () =>
                  context.push('/categories/$categoryId/products'),
              child: const Text('View all products'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppDimens.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "View all" button for this category
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.push('/categories/$categoryId/products'),
              icon: const Icon(Icons.grid_view),
              label: const Text('View all products in this category'),
            ),
          ),
          const SizedBox(height: AppDimens.md),

          Text(
            'Sub-categories',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: AppDimens.sm),

          // Sub-category grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimens.sm,
                mainAxisSpacing: AppDimens.sm,
                childAspectRatio: 1.1,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) {
                final subCat = children[index];
                return CategoryCard(
                  category: subCat,
                  onTap: () => context.push(
                    '/categories/$categoryId/products',
                    extra: {'sub_category_id': subCat.id},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
