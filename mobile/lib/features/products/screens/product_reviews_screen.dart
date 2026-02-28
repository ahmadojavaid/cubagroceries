import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Paginated reviews provider keyed by (productId, page)
final _paginatedReviewsProvider = FutureProvider.family<
    Map<String, dynamic>, ({int productId, int page})>((ref, params) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get(
    '/products/${params.productId}/reviews?page=${params.page}&per_page=15',
  );
  final data = response.data;
  if (data['success'] == true) {
    final reviews = data['data'] is List
        ? data['data'] as List
        : (data['data']['data'] ?? []) as List;
    return {
      'reviews': List<Map<String, dynamic>>.from(reviews),
      'total': data['meta']?['total'] ?? 0,
      'last_page': data['meta']?['last_page'] ?? 1,
    };
  }
  return {'reviews': [], 'total': 0, 'last_page': 1};
});

class ProductReviewsScreen extends ConsumerStatefulWidget {
  final int productId;
  final String productName;

  const ProductReviewsScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  ConsumerState<ProductReviewsScreen> createState() =>
      _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends ConsumerState<ProductReviewsScreen> {
  final _scrollController = ScrollController();
  final List<Map<String, dynamic>> _reviews = [];
  int _currentPage = 1;
  int _lastPage = 1;
  int _total = 0;
  bool _isLoadingMore = false;
  bool _initialLoaded = false;
  double _average = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _currentPage < _lastPage) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    _currentPage++;
    // Trigger fetch by reading provider — we'll handle in build
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Fetch current page
    final pageAsync = ref.watch(
      _paginatedReviewsProvider(
          (productId: widget.productId, page: _currentPage)),
    );

    // Process data when available
    pageAsync.whenData((data) {
      final newReviews = data['reviews'] as List<Map<String, dynamic>>;
      _lastPage = data['last_page'] as int;
      _total = data['total'] as int;

      if (!_initialLoaded || _currentPage == 1) {
        _reviews.clear();
        _initialLoaded = true;
      }

      // Only add if not already present (avoid duplicates on rebuild)
      final existingCount = _reviews.length;
      final expectedForPage = (_currentPage - 1) * 15;
      if (existingCount <= expectedForPage) {
        _reviews.addAll(newReviews);
      }

      // Calculate average from all loaded reviews
      if (_reviews.isNotEmpty) {
        double sum = 0;
        for (final r in _reviews) {
          sum += (r['rating'] as int? ?? 0);
        }
        _average = sum / _reviews.length;
      }

      _isLoadingMore = false;
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: pageAsync.when(
        loading: () => _reviews.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : _buildList(), // Show existing while loading more
        error: (e, _) => _reviews.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 40, color: AppColors.textHint),
                    const SizedBox(height: 12),
                    const Text('Failed to load reviews',
                        style: TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        _currentPage = 1;
                        ref.invalidate(_paginatedReviewsProvider(
                          (productId: widget.productId, page: 1),
                        ));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            : _buildList(),
        data: (_) => _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_reviews.isEmpty) {
      return const Center(
        child: Text('No reviews yet',
            style: TextStyle(color: AppColors.textHint, fontSize: 15)),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        _currentPage = 1;
        _reviews.clear();
        _initialLoaded = false;
        ref.invalidate(_paginatedReviewsProvider(
          (productId: widget.productId, page: 1),
        ));
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Summary header
          SliverToBoxAdapter(child: _buildSummaryHeader()),

          // Reviews list
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.pagePadding,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < _reviews.length) {
                    return _ReviewTile(review: _reviews[index]);
                  }
                  // Loading more indicator
                  if (_currentPage < _lastPage) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  }
                  return null;
                },
                childCount:
                    _reviews.length + (_currentPage < _lastPage ? 1 : 0),
              ),
            ),
          ),

          // Bottom spacing
          const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        AppDimens.md,
        AppDimens.pagePadding,
        AppDimens.md,
      ),
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // Big rating number
          Column(
            children: [
              Text(
                _average.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'out of 5',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Stars + count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (i) {
                    if (i < _average.floor()) {
                      return const Icon(Icons.star_rounded,
                          size: 24, color: AppColors.ratingStar);
                    } else if (i < _average.ceil() && _average % 1 >= 0.3) {
                      return const Icon(Icons.star_half_rounded,
                          size: 24, color: AppColors.ratingStar);
                    }
                    return Icon(Icons.star_border_rounded,
                        size: 24,
                        color: AppColors.ratingStar.withOpacity(0.3));
                  }),
                ),
                const SizedBox(height: 6),
                Text(
                  '$_total verified review${_total == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Review Tile ────────────────────────────────────────────

class _ReviewTile extends StatelessWidget {
  final Map<String, dynamic> review;

  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    final rating = review['rating'] as int? ?? 0;
    final comment = review['comment'] as String?;
    final customer = review['customer'] as String? ?? 'Customer';
    final createdAt = review['created_at'] as String?;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.sm + 2),
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar + name + date
          Row(
            children: [
              // Avatar
              _CustomerAvatar(name: customer),
              const SizedBox(width: 10),
              // Name + date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (createdAt != null) ...[
                      const SizedBox(height: 1),
                      Text(
                        _formatDate(createdAt),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Verified badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_rounded,
                        size: 12, color: AppColors.success),
                    SizedBox(width: 3),
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Stars row
          Row(
            children: List.generate(
              5,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Icon(
                  i < rating
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: AppColors.ratingStar,
                  size: 18,
                ),
              ),
            ),
          ),

          // Comment
          if (comment != null && comment.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              comment,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month]}, ${dt.year}';
    } catch (_) {
      return '';
    }
  }
}

class _CustomerAvatar extends StatelessWidget {
  final String name;

  const _CustomerAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    // Extract initials: "Ali K." → "AK"
    final parts = name.trim().split(RegExp(r'\s+'));
    String initials = '';
    if (parts.isNotEmpty) initials += parts.first.isNotEmpty ? parts.first[0] : '';
    if (parts.length > 1 && parts.last.isNotEmpty) {
      initials += parts.last[0].replaceAll('.', '');
    }

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
