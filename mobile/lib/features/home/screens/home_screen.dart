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
            icon: const Icon(Icons.search_rounded),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
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
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        children: [
          const SizedBox(height: AppDimens.lg),
          const ShimmerBox(width: 240, height: 28),
          const SizedBox(height: AppDimens.xs),
          const ShimmerBox(width: 160, height: 16),
          const SizedBox(height: AppDimens.xl),
          const ShimmerBox(width: 100, height: 18),
          const SizedBox(height: AppDimens.md),
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
        message: 'No categories available yet',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      children: [
        const SizedBox(height: AppDimens.sm),

        // Welcome
        Text(
          'What would you\nlike to buy?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                height: 1.15,
              ),
        ),
        const SizedBox(height: AppDimens.xs),
        Text(
          'Fresh groceries delivered to your door',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: AppDimens.xl),

        // Section heading
        Text(
          'Categories',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimens.md),

        // Categories grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppDimens.md,
            mainAxisSpacing: AppDimens.md,
            childAspectRatio: 1.05,
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

        const SizedBox(height: AppDimens.xl),
      ],
    );
  }

  void _onCategoryTap(int categoryId, bool hasChildren) {
    if (hasChildren) {
      context.push('/categories/$categoryId');
    } else {
      context.push('/categories/$categoryId/products');
    }
  }
}
