import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../categories/providers/category_provider.dart';
import '../../categories/widgets/category_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch categories on first load
    Future.microtask(
      () => ref.read(categoriesProvider.notifier).fetchCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catState = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuba Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(categoriesProvider.notifier)
            .fetchCategories(forceRefresh: true),
        child: _buildBody(catState),
      ),
    );
  }

  Widget _buildBody(CategoriesState state) {
    if (state.isLoading) {
      return ListView(
        padding: const EdgeInsets.all(AppDimens.md),
        children: [
          const SizedBox(height: AppDimens.xl),
          const ShimmerBox(width: 220, height: 24),
          const SizedBox(height: AppDimens.lg),
          const ShimmerBox(width: 120, height: 20),
          const SizedBox(height: AppDimens.sm),
          const CategoryGridShimmer(),
        ],
      );
    }

    if (state.error != null) {
      return ErrorStateWidget(
        message: state.error!,
        onRetry: () => ref
            .read(categoriesProvider.notifier)
            .fetchCategories(forceRefresh: true),
      );
    }

    if (state.categories.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.storefront_outlined,
        message: 'No categories available',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppDimens.md),
      children: [
        // Welcome section
        Text(
          'What would you like to buy?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: AppDimens.md),

        // Categories grid
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: AppDimens.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppDimens.sm,
            mainAxisSpacing: AppDimens.sm,
            childAspectRatio: 1.1,
          ),
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            return CategoryCard(
              category: category,
              onTap: () => _onCategoryTap(category.id, category.hasChildren),
            );
          },
        ),
      ],
    );
  }

  void _onCategoryTap(int categoryId, bool hasChildren) {
    if (hasChildren) {
      // Navigate to category listing (shows sub-categories)
      context.push('/categories/$categoryId');
    } else {
      // Navigate directly to products for this category
      context.push('/categories/$categoryId/products');
    }
  }


}
