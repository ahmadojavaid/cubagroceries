import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
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
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return _buildError(state.error!);
    }

    if (state.categories.isEmpty) {
      return _buildEmpty();
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

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppDimens.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppDimens.md),
            ElevatedButton(
              onPressed: () => ref
                  .read(categoriesProvider.notifier)
                  .fetchCategories(forceRefresh: true),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.storefront_outlined,
              size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          Text(
            'No categories available',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
