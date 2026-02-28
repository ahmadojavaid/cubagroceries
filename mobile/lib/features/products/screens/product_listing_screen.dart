import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../categories/providers/category_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

/// Paginated product listing screen, filterable by category/sub-category.
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

  @override
  void initState() {
    super.initState();
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
          subCategoryId: widget.subCategoryId,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(productsProvider.notifier).loadMore(
            categoryId: widget.categoryId,
            subCategoryId: widget.subCategoryId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsProvider);

    // Resolve title from categories provider
    final catNotifier = ref.read(categoriesProvider.notifier);
    final category = widget.subCategoryId != null
        ? catNotifier.findById(widget.subCategoryId!)
        : catNotifier.findById(widget.categoryId);
    final title = category?.title ?? 'Products';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: RefreshIndicator(
        onRefresh: () async => _fetchProducts(),
        child: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProductsState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.products.isEmpty) {
      return _buildError(context, state.error!);
    }

    if (state.products.isEmpty) {
      return _buildEmpty(context);
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppDimens.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimens.sm,
        mainAxisSpacing: AppDimens.sm,
        childAspectRatio: 0.7,
      ),
      itemCount: state.products.length + (state.isLoadingMore ? 2 : 0),
      itemBuilder: (context, index) {
        // Loading indicator at bottom
        if (index >= state.products.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.md),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final product = state.products[index];
        return ProductCard(
          product: product,
          onTap: () => context.push('/products/${product.id}'),
        );
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
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
              onPressed: _fetchProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined,
              size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          Text(
            'No products found',
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
