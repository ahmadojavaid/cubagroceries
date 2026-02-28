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
      'reviews': List<Map<String, dynamic>>.from(data['data']['data'] ?? data['data'] ?? []),
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
          error: (_, __) => Text(
            'Could not load reviews',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          data: (data) {
            final reviews = data['reviews'] as List;
            if (reviews.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'No reviews yet. Be the first to review!',
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
                      style: TextStyle(
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
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Stars
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                customer,
                style: TextStyle(
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

/// Dialog for writing a review
class WriteReviewDialog extends ConsumerStatefulWidget {
  final int productId;
  final int? orderId;

  const WriteReviewDialog({
    super.key,
    required this.productId,
    this.orderId,
  });

  @override
  ConsumerState<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends ConsumerState<WriteReviewDialog> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

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

    setState(() => _isSubmitting = true);

    try {
      final api = ref.read(apiClientProvider);
      final response = await api.post('/reviews', data: {
        'product_id': widget.productId,
        if (widget.orderId != null) 'order_id': widget.orderId,
        'rating': _rating,
        'comment': _commentController.text.trim().isEmpty
            ? null
            : _commentController.text.trim(),
      });

      if (!mounted) return;

      final data = response.data;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Review submitted!')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit review'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Write a Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => IconButton(
                onPressed: () => setState(() => _rating = i + 1),
                icon: Icon(
                  i < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }
}
