import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

// ─── Search History Provider ────────────────────────────────

final searchHistoryProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/search-history');
  final data = response.data;
  if (data['success'] == true && data['data'] != null) {
    return List<Map<String, dynamic>>.from(data['data']);
  }
  return [];
});

// ─── Screen ─────────────────────────────────────────────────

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(searchProductsProvider.notifier).reset());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _doSearch(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() => _hasSearched = true);
    ref.read(searchProductsProvider.notifier).search(q);
    // Refresh history after search completes
    Future.delayed(const Duration(milliseconds: 500), () {
      ref.invalidate(searchHistoryProvider);
    });
  }

  void _clearSearch() {
    _controller.clear();
    ref.read(searchProductsProvider.notifier).reset();
    setState(() => _hasSearched = false);
  }

  void _clearAllHistory() async {
    try {
      final api = ref.read(apiClientProvider);
      await api.delete('/search-history');
      ref.invalidate(searchHistoryProvider);
    } catch (_) {}
  }

  void _deleteHistoryItem(int id) async {
    try {
      final api = ref.read(apiClientProvider);
      await api.delete('/search-history/$id');
      ref.invalidate(searchHistoryProvider);
    } catch (_) {}
  }

  void _tapHistoryItem(String query) {
    _controller.text = query;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    _doSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProductsProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          height: 42,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceBg,
            borderRadius: BorderRadius.circular(AppDimens.radiusFull),
          ),
          child: TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onSubmitted: _doSearch,
            onChanged: (_) => setState(() {}), // Update clear button visibility
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: const TextStyle(
                color: AppColors.textHint,
                fontSize: 15,
              ),
              prefixIcon: const Icon(Icons.search_rounded,
                  size: 20, color: AppColors.textHint),
              suffixIcon: _controller.text.isNotEmpty
                  ? GestureDetector(
                      onTap: _clearSearch,
                      child: const Icon(Icons.close_rounded,
                          size: 18, color: AppColors.textHint),
                    )
                  : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 11,
              ),
            ),
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
      body: _hasSearched ? _buildResults(context, state) : _buildHistory(),
    );
  }

  // ─── Search Results ───────────────────────────────────────

  Widget _buildResults(BuildContext context, ProductsState state) {
    if (state.isLoading) {
      return const ProductGridShimmer(itemCount: 4);
    }

    if (state.error != null && state.products.isEmpty) {
      return ErrorStateWidget(message: state.error!);
    }

    if (state.products.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.search_off_rounded,
        message: 'No products found for "${_controller.text}"',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimens.md,
        mainAxisSpacing: AppDimens.md,
        childAspectRatio: 0.68,
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final product = state.products[index];
        return ProductCard(
          product: product,
          onTap: () => context.push('/products/${product.id}'),
        );
      },
    );
  }

  // ─── Search History ───────────────────────────────────────

  Widget _buildHistory() {
    final historyAsync = ref.watch(searchHistoryProvider);

    return historyAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => _buildEmptySearchState(),
      data: (history) {
        if (history.isEmpty) return _buildEmptySearchState();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(Icons.history_rounded,
                      size: 18, color: AppColors.textHint),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _clearAllHistory,
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.md),

              // History items
              ...history.map((item) => _HistoryItem(
                    id: item['id'] as int,
                    query: item['query'] as String,
                    resultsCount: item['results_count'] as int? ?? 0,
                    onTap: () => _tapHistoryItem(item['query'] as String),
                    onDelete: () => _deleteHistoryItem(item['id'] as int),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptySearchState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_rounded,
                size: 32, color: AppColors.primary),
          ),
          const SizedBox(height: AppDimens.md),
          const Text(
            'Search for products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Type a product name and press search',
            style: TextStyle(fontSize: 13, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }
}

// ─── History Item Widget ────────────────────────────────────

class _HistoryItem extends StatelessWidget {
  final int id;
  final String query;
  final int resultsCount;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryItem({
    required this.id,
    required this.query,
    required this.resultsCount,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            const Icon(Icons.history_rounded,
                size: 18, color: AppColors.textHint),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                query,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (resultsCount > 0)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  '$resultsCount result${resultsCount == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textHint,
                  ),
                ),
              ),
            GestureDetector(
              onTap: onDelete,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close_rounded,
                    size: 16, color: AppColors.textHint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
