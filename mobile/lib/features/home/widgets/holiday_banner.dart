import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/holiday_model.dart';

/// Full-width banner displayed at the top of the home screen during holiday mode.
class HolidayBanner extends StatelessWidget {
  final HolidayModel holiday;
  final VoidCallback? onOrderForLater;

  const HolidayBanner({
    super.key,
    required this.holiday,
    this.onOrderForLater,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(
          color: AppColors.warning.withOpacity(0.3),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image (if provided)
          if (holiday.image != null)
            CachedNetworkImage(
              imageUrl: holiday.image!,
              height: 160,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                height: 160,
                color: AppColors.warning.withOpacity(0.1),
                child: const Center(
                  child: Icon(Icons.image_outlined,
                      size: 40, color: AppColors.textHint),
                ),
              ),
              errorWidget: (_, __, ___) => const SizedBox.shrink(),
            ),

          // Content
          Container(
            padding: const EdgeInsets.all(AppDimens.md),
            color: AppColors.warning.withOpacity(0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon + title row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.event_busy_rounded,
                          size: 22, color: AppColors.warning),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        holiday.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Message
                Text(
                  holiday.message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),

                // Reopening date
                if (holiday.holidayEnd != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.schedule_rounded,
                            size: 16, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Text(
                          'Reopens ${DateFormat('EEE, MMM d • h:mm a').format(holiday.holidayEnd!)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Order for Later button
                if (holiday.allowAdvanceOrders && onOrderForLater != null) ...[
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onOrderForLater,
                      icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                      label: const Text('Order for Later'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusMd),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
