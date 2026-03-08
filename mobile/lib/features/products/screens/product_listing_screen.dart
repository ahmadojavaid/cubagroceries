import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../categories/providers/category_provider.dart';
import '../../categories/data/category_model.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListingScreen extends ConsumerStatefulWidget {
  final int categoryId;
  final int? subCategoryId;

  const ProductListingScreen({
    super.key,
    required this.categoryId,
    this.subCategoryId,
  });

  @override
  ConsumerState<ProductListingScreen> createState() =>
      _ProductListingScreenState();
}

class _ProductListingScreenState extends ConsumerState<ProductListingScreen> {
  final _scrollController = ScrollController();
  late int? _activeSubCategoryId;

  @override
  void initState() {
    super.initState();
    _activeSubCategoryId = widget.subCategoryId;
    Future.microtask(() => _fetchProducts());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchProducts() {
    ref.read(productsProvider.notifier).fetchProducts(
          categoryId: widget.categoryId,
          subCategoryId: _activeSubCategoryId,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(productsProvider.notifier).loadMore(
            categoryId: widget.categoryId,
            subCategoryId: _activeSubCategoryId,
          );
    }
  }

  void _onFilterChanged(int? subCategoryId) {
    setState(() => _activeSubCategoryId = subCategoryId);
    _fetchProducts();
    // Scroll to top
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsProvider);
    final catNotifier = ref.read(categoriesProvider.notifier);
    final category = catNotifier.findById(widget.categoryId);
    final children = catNotifier.getChildren(widget.categoryId);
    final title = category?.title ?? 'Products';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => _fetchProducts(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Sub-category filter chips
            if (children.isNotEmpty)
              SliverToBoxAdapter(
                child: _buildFilterChips(children),
              ),

            // Result count
            if (!state.isLoading && state.products.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.pagePadding,
                    AppDimens.sm,
                    AppDimens.pagePadding,
                    AppDimens.sm,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${state.meta?.total ?? state.products.length} products',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_activeSubCategoryId != null) ...[
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _onFilterChanged(null),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.radiusFull),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Filtered',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.close_rounded,
                                    size: 12, color: AppColors.primary),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

            // Content
            _buildContent(state),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(List<CategoryModel> children) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.pagePadding,
          vertical: 6,
        ),
        itemCount: children.length + 1, // +1 for "All"
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _FilterChip(
              label: 'All',
              isActive: _activeSubCategoryId == null,
              onTap: () => _onFilterChanged(null),
            );
          }
          final subCat = children[index - 1];
          return _FilterChip(
            label: subCat.title,
            isActive: _activeSubCategoryId == subCat.id,
            onTap: () => _onFilterChanged(subCat.id),
          );
        },
      ),
    );
  }

  Widget _buildContent(ProductsState state) {
    if (state.isLoading) {
      return const SliverFillRemaining(
        child: ProductGridShimmer(),
      );
    }

    if (state.error != null && state.products.isEmpty) {
      return SliverFillRemaining(
        child: ErrorStateWidget(
            message: state.error!, onRetry: _fetchProducts),
      );
    }

    if (state.products.isEmpty) {
      return const SliverFillRemaining(
        child: EmptyStateWidget(
          icon: Icons.inventory_2_outlined,
          message: 'No products found',
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        AppDimens.sm,
        AppDimens.pagePadding,
        AppDimens.xl,
      ),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimens.md,
          mainAxisSpacing: AppDimens.md,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= state.products.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.md),
                  child: CircularProgressIndicator(strokeWidth: 1.5),
                ),
              );
            }

            final product = state.products[index];
            return ProductCard(
              product: product,
              onTap: () => context.push('/products/${product.id}'),
            );
          },
          childCount:
              state.products.length + (state.isLoadingMore ? 2 : 0),
        ),
      ),
    );
  }
}

// ─── Filter Chip ────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusFull),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
