import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Provider for fetching a lightweight review summary for a product
final productReviewSummaryProvider =
    FutureProvider.family<Map<String, dynamic>?, int>((ref, productId) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.get('/products/$productId/reviews?per_page=1');
  final data = response.data;
  if (data['success'] == true) {
    final reviews = data['data'] is List
        ? data['data'] as List
        : (data['data']['data'] ?? []) as List;
    final total = data['meta']?['total'] ?? reviews.length;
    if (total == 0) return null;

    // We need avg — compute from total & first page isn't enough.
    // Fetch a bigger batch to compute avg (API returns paginated)
    final fullResp =
        await api.get('/products/$productId/reviews?per_page=$total');
    final fullData = fullResp.data;
    final allReviews = fullData['data'] is List
        ? fullData['data'] as List
        : (fullData['data']['data'] ?? []) as List;

    double sum = 0;
    for (final r in allReviews) {
      sum += (r['rating'] as int? ?? 0);
    }

    return {
      'average': allReviews.isNotEmpty ? sum / allReviews.length : 0.0,
      'total': total,
    };
  }
  return null;
});

/// Compact rating indicator for product detail — tappable to open reviews screen
class ProductRatingIndicator extends ConsumerWidget {
  final int productId;
  final String productName;

  const ProductRatingIndicator({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(productReviewSummaryProvider(productId));

    return summaryAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (summary) {
        if (summary == null) {
          // No reviews — show subtle hint
          return _NoReviewsHint();
        }

        final avg = (summary['average'] as double);
        final total = summary['total'] as int;

        return Material(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          child: InkWell(
            onTap: () => context.push(
              '/products/$productId/reviews',
              extra: {'product_name': productName},
            ),
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
              ),
              child: Row(
                children: [
                  // Stars
                  ...List.generate(5, (i) {
                    if (i < avg.floor()) {
                      return const Icon(Icons.star_rounded,
                          size: 20, color: AppColors.ratingStar);
                    } else if (i < avg.ceil() && avg % 1 >= 0.3) {
                      return const Icon(Icons.star_half_rounded,
                          size: 20, color: AppColors.ratingStar);
                    }
                    return Icon(Icons.star_border_rounded,
                        size: 20,
                        color: AppColors.ratingStar.withValues(alpha: 0.35));
                  }),
                  const SizedBox(width: 10),
                  // Average
                  Text(
                    avg.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Count
                  Text(
                    '($total)',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textHint,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded,
                      size: 22, color: AppColors.textHint),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NoReviewsHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.star_border_rounded,
              size: 18, color: AppColors.textHint.withValues(alpha: 0.5)),
          const SizedBox(width: 6),
          const Text(
            'No reviews yet',
            style: TextStyle(fontSize: 13, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }
}
