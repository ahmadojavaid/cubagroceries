import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/category_provider.dart';
import '../widgets/category_card.dart';

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
      return EmptyStateWidget(
        icon: Icons.folder_open_outlined,
        message: 'No sub-categories found',
        actionLabel: 'View all products',
        onAction: () =>
            context.push('/categories/$categoryId/products'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // View all button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.push('/categories/$categoryId/products'),
              icon: const Icon(Icons.grid_view_rounded, size: 18),
              label: const Text('View all products'),
            ),
          ),
          const SizedBox(height: AppDimens.lg),

          Text(
            'Sub-categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppDimens.md),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimens.md,
                mainAxisSpacing: AppDimens.md,
                childAspectRatio: 1.05,
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
