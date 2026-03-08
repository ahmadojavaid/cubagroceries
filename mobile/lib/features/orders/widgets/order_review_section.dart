import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../providers/order_provider.dart';

// ─── Providers ──────────────────────────────────────────────

/// Fetch the user's order-level review for an order
final orderReviewProvider =
    FutureProvider.family<Map<String, dynamic>?, int>((ref, orderId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/orders/$orderId/review');
  final data = response.data;
  if (data['success'] == true && data['data'] != null) {
    return Map<String, dynamic>.from(data['data']);
  }
  return null;
});

/// Fetch reviewable products + their review status for an order
final reviewableProductsProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, orderId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/orders/$orderId/reviewable-products');
  final data = response.data;
  if (data['success'] == true) {
    return {
      'products': List<Map<String, dynamic>>.from(data['data'] ?? []),
      'can_review': data['can_review'] ?? false,
    };
  }
  return {'products': [], 'can_review': false};
});

// ─── Main Widget ────────────────────────────────────────────

class OrderReviewSection extends ConsumerWidget {
  final int orderId;
  final String orderStatus;
  final bool isReviewed;
  final int? reviewRating;
  final String? reviewComment;

  const OrderReviewSection({
    super.key,
    required this.orderId,
    required this.orderStatus,
    this.isReviewed = false,
    this.reviewRating,
    this.reviewComment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show for delivered orders
    if (orderStatus != 'delivered') return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppDimens.md),
        _OrderReviewCard(
          orderId: orderId,
          isReviewed: isReviewed,
          existingRating: reviewRating,
          existingComment: reviewComment,
        ),
        const SizedBox(height: AppDimens.sm),
        _ProductReviewsCard(orderId: orderId),
      ],
    );
  }
}

// ─── Order-Level Review Card ────────────────────────────────

class _OrderReviewCard extends ConsumerWidget {
  final int orderId;
  final bool isReviewed;
  final int? existingRating;
  final String? existingComment;

  const _OrderReviewCard({
    required this.orderId,
    this.isReviewed = false,
    this.existingRating,
    this.existingComment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: isReviewed
          ? _ExistingReview(
              title: 'Your Order Rating',
              rating: existingRating ?? 5,
              comment: existingComment,
            )
          : _ReviewPrompt(
              icon: Icons.star_border_rounded,
              title: 'Rate your experience',
              subtitle: 'How was your overall order?',
              buttonLabel: 'Rate Order',
              onTap: () => _showOrderReviewDialog(context, ref),
            ),
    );
  }

  void _showOrderReviewDialog(BuildContext context, WidgetRef ref) {
    // Read the order number before showing dialog
    final orderNumber = ref.read(orderActionProvider).placedOrder?.orderId;

    showDialog(
      context: context,
      builder: (_) => _WriteReviewDialog(
        title: 'Rate Your Order',
        subtitle: 'How was your overall experience with this order?',
        onSubmit: (rating, comment) async {
          final api = ref.read(apiClientProvider);
          await api.post('/order-reviews', data: {
            'order_id': orderId,
            'rating': rating,
            'comment': comment,
          });
          // Refetch order detail so isReviewed updates
          if (orderNumber != null) {
            ref.read(orderActionProvider.notifier).fetchOrderDetail(orderNumber);
          }
        },
      ),
    );
  }
}

// ─── Product-Level Reviews Card ─────────────────────────────

class _ProductReviewsCard extends ConsumerWidget {
  final int orderId;
  const _ProductReviewsCard({required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewableAsync = ref.watch(reviewableProductsProvider(orderId));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: reviewableAsync.when(
        loading: () => const _SectionShimmer(),
        error: (_, __) => const Text('Could not load products',
            style: TextStyle(color: AppColors.textHint, fontSize: 13)),
        data: (data) {
          final products =
              data['products'] as List<Map<String, dynamic>>;
          final canReview = data['can_review'] as bool;

          if (products.isEmpty) return const SizedBox.shrink();

          final allReviewed = products.every((p) => p['reviewed'] == true);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.rate_review_outlined,
                      size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Rate Products',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (allReviewed)
                    const Icon(Icons.check_circle_rounded,
                        size: 18, color: AppColors.success),
                ],
              ),
              const SizedBox(height: AppDimens.sm + 2),
              ...products.map((p) => _ProductReviewRow(
                    orderId: orderId,
                    productId: p['product_id'] as int,
                    productName: p['product_name'] as String,
                    reviewed: p['reviewed'] as bool,
                    canReview: canReview,
                  )),
            ],
          );
        },
      ),
    );
  }
}

class _ProductReviewRow extends ConsumerWidget {
  final int orderId;
  final int productId;
  final String productName;
  final bool reviewed;
  final bool canReview;

  const _ProductReviewRow({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.reviewed,
    required this.canReview,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              productName,
              style: TextStyle(
                fontSize: 14,
                color: reviewed
                    ? AppColors.textHint
                    : AppColors.textPrimary,
              ),
            ),
          ),
          if (reviewed)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.08),
                borderRadius:
                    BorderRadius.circular(AppDimens.radiusFull),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, size: 14, color: AppColors.success),
                  SizedBox(width: 4),
                  Text('Reviewed',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success)),
                ],
              ),
            )
          else if (canReview)
            SizedBox(
              height: 32,
              child: TextButton(
                onPressed: () => _showProductReviewDialog(context, ref),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text('Rate',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ),
        ],
      ),
    );
  }

  void _showProductReviewDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => _WriteReviewDialog(
        title: 'Rate Product',
        subtitle: productName,
        onSubmit: (rating, comment) async {
          final api = ref.read(apiClientProvider);
          await api.post('/reviews', data: {
            'product_id': productId,
            'order_id': orderId,
            'rating': rating,
            'comment': comment,
          });
          ref.invalidate(reviewableProductsProvider(orderId));
        },
      ),
    );
  }
}

// ─── Shared Widgets ─────────────────────────────────────────

class _ReviewPrompt extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onTap;

  const _ReviewPrompt({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 22, color: AppColors.warning),
        ),
        const SizedBox(width: AppDimens.sm + 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textHint)),
            ],
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            backgroundColor: AppColors.primary.withOpacity(0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
          ),
          child: Text(buttonLabel,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _ExistingReview extends StatelessWidget {
  final String title;
  final int rating;
  final String? comment;

  const _ExistingReview({
    required this.title,
    required this.rating,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                size: 18, color: AppColors.success),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
              5,
              (i) => Icon(
                    i < rating ? Icons.star_rounded : Icons.star_border_rounded,
                    color: AppColors.ratingStar,
                    size: 22,
                  )),
        ),
        if (comment != null && comment!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(comment!,
              style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5)),
        ],
      ],
    );
  }
}

class _SectionShimmer extends StatelessWidget {
  const _SectionShimmer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

// ─── Write Review Dialog ────────────────────────────────────

class _WriteReviewDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final Future<void> Function(int rating, String? comment) onSubmit;

  const _WriteReviewDialog({
    required this.title,
    required this.subtitle,
    required this.onSubmit,
  });

  @override
  State<_WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<_WriteReviewDialog> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      setState(() => _error = 'Please select a rating');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final comment = _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim();
      await widget.onSubmit(_rating, comment);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Review submitted!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        try {
          final dioErr = e as dynamic;
          _error =
              dioErr.response?.data?['message'] ?? 'Failed to submit review';
        } catch (_) {
          _error = 'Failed to submit review';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusLg)),
      title: Text(widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.subtitle,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 16),

          // Star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    i < _rating
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
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
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
            ),
          ),

          // Error
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!,
                style:
                    const TextStyle(color: AppColors.error, fontSize: 12)),
          ],
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
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }
}
