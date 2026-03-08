import 'dart:async';
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
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(searchProductsProvider.notifier).reset());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final q = value.trim();

    if (q.isEmpty) {
      ref.read(searchProductsProvider.notifier).reset();
      setState(() {});
      return;
    }

    // Start searching after 2 characters with 400ms debounce
    if (q.length >= 2) {
      _debounce = Timer(const Duration(milliseconds: 400), () {
        ref.read(searchProductsProvider.notifier).search(q);
      });
    }

    setState(() {});
  }

  void _onSubmitted(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    FocusScope.of(context).unfocus();
    ref.read(searchProductsProvider.notifier).search(q);
    // Refresh history after search is logged
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) ref.invalidate(searchHistoryProvider);
    });
  }

  void _clearSearch() {
    _controller.clear();
    _debounce?.cancel();
    ref.read(searchProductsProvider.notifier).reset();
    setState(() {});
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
    _onSubmitted(query);
  }

  bool get _showResults => _controller.text.trim().length >= 2;

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
            onChanged: _onChanged,
            onSubmitted: _onSubmitted,
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
      body: _showResults ? _buildResults(context, state) : _buildHistory(),
    );
  }

  // ─── Search Results ───────────────────────────────────────

  Widget _buildResults(BuildContext context, ProductsState state) {
    if (state.isLoading && state.products.isEmpty) {
      return const ProductGridShimmer(itemCount: 4);
    }

    if (state.error != null && state.products.isEmpty) {
      return ErrorStateWidget(message: state.error!);
    }

    if (!state.isLoading && state.products.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.search_off_rounded,
        message: 'No products found for "${_controller.text.trim()}"',
      );
    }

    return Stack(
      children: [
        GridView.builder(
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
        ),
        // Loading overlay for subsequent searches
        if (state.isLoading && state.products.isNotEmpty)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
      ],
    );
  }

  // ─── Search History ───────────────────────────────────────

  Widget _buildHistory() {
    final historyAsync = ref.watch(searchHistoryProvider);
    final typedText = _controller.text.trim();

    return historyAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => _buildEmptySearchState(),
      data: (history) {
        // Filter history by typed text if the user has typed something
        final filtered = typedText.isEmpty
            ? history
            : history
                .where((h) => (h['query'] as String)
                    .toLowerCase()
                    .contains(typedText.toLowerCase()))
                .toList();

        if (filtered.isEmpty && typedText.isEmpty) {
          return _buildEmptySearchState();
        }

        if (filtered.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type at least 2 characters to search',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          );
        }

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
                  if (typedText.isEmpty)
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
              const SizedBox(height: AppDimens.sm),

              // History items
              ...filtered.map((item) => _HistoryItem(
                    id: item['id'] as int,
                    query: item['query'] as String,
                    resultsCount: item['results_count'] as int? ?? 0,
                    highlightQuery: typedText,
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
            'Start typing to find what you need',
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
  final String highlightQuery;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryItem({
    required this.id,
    required this.query,
    required this.resultsCount,
    this.highlightQuery = '',
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
            Expanded(child: _buildHighlightedText()),
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
            // Fill search bar icon (arrow top-left)
            GestureDetector(
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.north_west_rounded,
                    size: 14, color: AppColors.textHint),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText() {
    if (highlightQuery.isEmpty) {
      return Text(
        query,
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
      );
    }

    final lowerQuery = query.toLowerCase();
    final lowerHighlight = highlightQuery.toLowerCase();
    final matchIndex = lowerQuery.indexOf(lowerHighlight);

    if (matchIndex < 0) {
      return Text(
        query,
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
      );
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
        children: [
          if (matchIndex > 0)
            TextSpan(text: query.substring(0, matchIndex)),
          TextSpan(
            text: query.substring(matchIndex, matchIndex + highlightQuery.length),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          if (matchIndex + highlightQuery.length < query.length)
            TextSpan(
                text: query.substring(matchIndex + highlightQuery.length)),
        ],
      ),
    );
  }
}
