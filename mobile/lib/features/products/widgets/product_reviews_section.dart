import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Provider for fetching product reviews
final productReviewsProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, productId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/products/$productId/reviews');
  final data = response.data;
  if (data['success'] == true) {
    return {
      'reviews': List<Map<String, dynamic>>.from(
          data['data'] is List ? data['data'] : data['data']['data'] ?? []),
      'total': data['meta']?['total'] ?? 0,
    };
  }
  return {'reviews': [], 'total': 0};
});

/// Widget showing reviews section on product detail
class ProductReviewsSection extends ConsumerWidget {
  final int productId;
  final VoidCallback? onWriteReview;

  const ProductReviewsSection({
    super.key,
    required this.productId,
    this.onWriteReview,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(productReviewsProvider(productId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (onWriteReview != null)
              TextButton.icon(
                onPressed: onWriteReview,
                icon: const Icon(Icons.rate_review_outlined, size: 18),
                label: const Text('Write Review'),
              ),
          ],
        ),
        const SizedBox(height: AppDimens.sm),
        reviewsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (_, __) => const Text(
            'Could not load reviews',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          data: (data) {
            final reviews = data['reviews'] as List;
            if (reviews.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'No reviews yet.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              );
            }

            return Column(
              children: [
                for (final review in reviews.take(5))
                  _ReviewCard(review: Map<String, dynamic>.from(review)),
                if (reviews.length > 5)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'And ${(data['total'] as int) - 5} more reviews',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    final rating = review['rating'] as int? ?? 0;
    final comment = review['comment'] as String?;
    final customer = review['customer'] as String? ?? 'Customer';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: AppColors.ratingStar,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                customer,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (comment != null && comment.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              comment,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}

/// Dialog for writing a product review — requires selecting which order
class WriteReviewDialog extends ConsumerStatefulWidget {
  final int productId;

  const WriteReviewDialog({super.key, required this.productId});

  @override
  ConsumerState<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends ConsumerState<WriteReviewDialog> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;
  bool _isLoadingOrders = true;
  List<Map<String, dynamic>> _eligibleOrders = [];
  int? _selectedOrderId;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadEligibleOrders();
  }

  Future<void> _loadEligibleOrders() async {
    try {
      final api = ref.read(apiClientProvider);
      // Fetch user's orders, find delivered ones containing this product
      final response = await api.get('/orders', queryParameters: {
        'per_page': 50,
      });

      final data = response.data;
      if (data['success'] == true) {
        final orders = (data['data'] as List).cast<Map<String, dynamic>>();
        final delivered = orders.where((o) => o['status'] == 'delivered').toList();

        // For each delivered order, check if product was in it and not yet reviewed
        final eligible = <Map<String, dynamic>>[];
        for (final order in delivered) {
          final reviewableRes = await api.get('/orders/${order['id']}/reviewable-products');
          final rData = reviewableRes.data;
          if (rData['success'] == true && rData['can_review'] == true) {
            final items = (rData['data'] as List).cast<Map<String, dynamic>>();
            final match = items.where(
              (i) => i['product_id'] == widget.productId && i['reviewed'] == false,
            );
            if (match.isNotEmpty) {
              eligible.add(order);
            }
          }
        }

        if (mounted) {
          setState(() {
            _eligibleOrders = eligible;
            _selectedOrderId = eligible.isNotEmpty ? eligible.first['id'] as int : null;
            _isLoadingOrders = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingOrders = false;
          _error = 'Could not load orders';
        });
      }
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a rating')),
      );
      return;
    }
    if (_selectedOrderId == null) return;

    setState(() => _isSubmitting = true);

    try {
      final api = ref.read(apiClientProvider);
      final response = await api.post('/reviews', data: {
        'product_id': widget.productId,
        'order_id': _selectedOrderId,
        'rating': _rating,
        'comment': _commentController.text.trim().isEmpty
            ? null
            : _commentController.text.trim(),
      });

      if (!mounted) return;

      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message'] ?? 'Review submitted!'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      String msg = 'Failed to submit review';
      try {
        msg = (e as dynamic).response?.data?['message'] ?? msg;
      } catch (_) {}
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: _isLoadingOrders
            ? const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            : _error != null
                ? _buildError()
                : _eligibleOrders.isEmpty
                    ? _buildNoEligible()
                    : _buildForm(),
      ),
    );
  }

  Widget _buildError() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, size: 40, color: AppColors.error),
        const SizedBox(height: 12),
        Text(_error!, style: const TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }

  Widget _buildNoEligible() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.rate_review_outlined, size: 40, color: AppColors.textHint),
        const SizedBox(height: 12),
        const Text(
          'Can\'t review this product',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        const Text(
          'You can only review products from orders that have been delivered.',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Write a Review',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          // Order selector (if multiple)
          if (_eligibleOrders.length > 1) ...[
            const Text('For order:', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedOrderId,
                  isExpanded: true,
                  items: _eligibleOrders.map((o) {
                    return DropdownMenuItem<int>(
                      value: o['id'] as int,
                      child: Text(o['order_id'] as String? ?? '#${o['id']}',
                          style: const TextStyle(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedOrderId = v),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Star rating
          const Text('Rating', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    i < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: AppColors.ratingStar,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Comment
          TextField(
            controller: _commentController,
            maxLines: 3,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: 'Share your experience (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusSm),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isSubmitting || _rating == 0 ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Submit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
