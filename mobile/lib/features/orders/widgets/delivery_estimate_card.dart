import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/order_model.dart';

/// Shows a live countdown for estimated delivery time.
/// Only renders when the order has a valid estimate and is not delivered/cancelled.
class DeliveryEstimateCard extends StatefulWidget {
  final OrderDetailModel order;

  const DeliveryEstimateCard({super.key, required this.order});

  @override
  State<DeliveryEstimateCard> createState() => _DeliveryEstimateCardState();
}

class _DeliveryEstimateCardState extends State<DeliveryEstimateCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Tick every 30 seconds to update the remaining time
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    // Don't show for delivered/cancelled or if no estimate
    if (!order.hasDeliveryEstimate) return const SizedBox.shrink();
    if (order.status == 'delivered' || order.status == 'cancelled') {
      return const SizedBox.shrink();
    }

    final target = order.estDeliveryTime!;
    final now = DateTime.now();
    final remaining = target.difference(now);
    final isOverdue = remaining.isNegative;

    final mins = remaining.inMinutes.abs();
    final hours = mins ~/ 60;
    final remMins = mins % 60;

    // Build the time display
    String timeText;
    if (isOverdue) {
      timeText = hours > 0
          ? '${hours}h ${remMins}m overdue'
          : '${remMins}m overdue';
    } else if (remaining.inMinutes < 1) {
      timeText = 'Arriving now';
    } else {
      timeText = hours > 0
          ? '${hours}h ${remMins}m'
          : '${remMins} min';
    }

    // Progress: 0.0 (just set) to 1.0 (arrived)
    final totalMinutes = order.estDeliveryMinutes!;
    final elapsed = now.difference(order.estDeliverySetAt!).inMinutes;
    final progress = (elapsed / totalMinutes).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: isOverdue
            ? AppColors.warning.withValues(alpha: 0.06)
            : AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: isOverdue
              ? AppColors.warning.withValues(alpha: 0.25)
              : AppColors.primary.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(
                isOverdue
                    ? Icons.timer_off_outlined
                    : Icons.delivery_dining_rounded,
                size: 20,
                color: isOverdue ? AppColors.warning : AppColors.primary,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Estimated Delivery',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              // Time badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isOverdue
                      ? AppColors.warning.withValues(alpha: 0.12)
                      : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimens.radiusFull),
                ),
                child: Text(
                  timeText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color:
                        isOverdue ? AppColors.warning : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: isOverdue
                  ? AppColors.warning.withValues(alpha: 0.12)
                  : AppColors.primary.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation(
                isOverdue ? AppColors.warning : AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Footer: arrival time
          Text(
            isOverdue
                ? 'Your order is taking a bit longer than expected'
                : 'Expected by ${_formatTime(target)}',
            style: TextStyle(
              fontSize: 12,
              color: isOverdue
                  ? AppColors.warning.withValues(alpha: 0.8)
                  : AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final amPm = dt.hour >= 12 ? 'PM' : 'AM';
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min $amPm';
  }
}
