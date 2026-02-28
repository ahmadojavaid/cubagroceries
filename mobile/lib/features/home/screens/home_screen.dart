import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../categories/providers/category_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_slider.dart';
import '../widgets/featured_section_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(homeProvider.notifier).fetchHome();
      ref.read(categoriesProvider.notifier).fetchCategories();
    });
  }

  Future<void> _refresh() async {
    await Future.wait([
      ref.read(homeProvider.notifier).fetchHome(forceRefresh: true),
      ref.read(categoriesProvider.notifier).fetchCategories(forceRefresh: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
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
        onRefresh: _refresh,
        child: _buildBody(homeState, catState),
      ),
    );
  }

  Widget _buildBody(HomeState homeState, CategoriesState catState) {
    // Loading
    if (homeState.isLoading && !homeState.hasData) {
      return ListView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        children: const [
          SizedBox(height: AppDimens.sm),
          ShimmerBox(width: double.infinity, height: 170, borderRadius: AppDimens.radiusMd),
          SizedBox(height: AppDimens.lg),
          ShimmerBox(width: 100, height: 18),
          SizedBox(height: AppDimens.sm),
          ShimmerBox(width: double.infinity, height: 100),
          SizedBox(height: AppDimens.lg),
          ShimmerBox(width: 140, height: 18),
          SizedBox(height: AppDimens.sm),
          ShimmerBox(width: double.infinity, height: 195),
        ],
      );
    }

    // Error
    if (homeState.error != null && !homeState.hasData) {
      return ErrorStateWidget(
        message: homeState.error!,
        onRetry: _refresh,
      );
    }

    // Content
    return ListView(
      children: [
        const SizedBox(height: AppDimens.sm),

        // 1. Banner slider
        if (homeState.banners.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding),
            child: BannerSlider(banners: homeState.banners),
          ),

        if (homeState.banners.isNotEmpty)
          const SizedBox(height: AppDimens.lg),

        // 2. Categories horizontal slider
        if (catState.categories.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding),
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          CategorySlider(
            categories: catState.categories,
            onTap: (cat) {
              if (cat.hasChildren) {
                context.push('/categories/${cat.id}');
              } else {
                context.push('/categories/${cat.id}/products');
              }
            },
          ),
          const SizedBox(height: AppDimens.lg),
        ],

        // 3. Featured category sections
        ...homeState.featuredSections.map((section) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.lg),
              child: FeaturedSectionWidget(section: section),
            )),

        // Empty state if nothing at all
        if (homeState.banners.isEmpty &&
            catState.categories.isEmpty &&
            homeState.featuredSections.isEmpty)
          const EmptyStateWidget(
            icon: Icons.storefront_outlined,
            message: 'No content available yet',
          ),

        const SizedBox(height: AppDimens.xl),
      ],
    );
  }
}
