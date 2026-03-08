import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Reusable order review popup dialog.
/// Shows star rating + optional comment, submits to POST /order-reviews.
/// Dismissible (user can skip).
class OrderReviewPopup extends StatefulWidget {
  final int orderId;
  final String orderNumber;
  final VoidCallback? onSubmitted;

  const OrderReviewPopup({
    super.key,
    required this.orderId,
    required this.orderNumber,
    this.onSubmitted,
  });

  @override
  State<OrderReviewPopup> createState() => _OrderReviewPopupState();
}

class _OrderReviewPopupState extends State<OrderReviewPopup> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded,
                color: AppColors.warning, size: 32),
          ),
          const SizedBox(height: 12),
          const Text(
            'How was your order?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '#${widget.orderNumber}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textHint,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Star rating row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedScale(
                    scale: i < _rating ? 1.15 : 1.0,
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      i < _rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: AppColors.ratingStar,
                      size: 40,
                    ),
                  ),
                ),
              );
            }),
          ),
          if (_rating > 0) ...[
            const SizedBox(height: 6),
            Text(
              _ratingLabel(_rating),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 16),

          // Comment field
          TextField(
            controller: _commentController,
            maxLines: 3,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: 'Tell us more (optional)',
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),

          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!,
                style:
                    const TextStyle(color: AppColors.error, fontSize: 12)),
          ],
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: const Text('Skip'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed:
                    _isSubmitting || _rating == 0 ? null : _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Submit Review',
                        style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _ratingLabel(int rating) {
    return switch (rating) {
      1 => 'Poor',
      2 => 'Fair',
      3 => 'Good',
      4 => 'Great',
      5 => 'Excellent!',
      _ => '',
    };
  }

  Future<void> _submitReview() async {
    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    try {
      final container = ProviderScope.containerOf(context);
      final api = container.read(apiClientProvider);

      final comment = _commentController.text.trim().isEmpty
          ? null
          : _commentController.text.trim();

      await api.post('/order-reviews', data: {
        'order_id': widget.orderId,
        'rating': _rating,
        'comment': comment,
      });

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Thanks for your review! ⭐'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      widget.onSubmitted?.call();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        try {
          final dioErr = e as dynamic;
          final msg = dioErr.response?.data?['message'];
          _error = msg ?? 'Failed to submit review';
        } catch (_) {
          _error = 'Failed to submit review';
        }
      });
    }
  }
}
