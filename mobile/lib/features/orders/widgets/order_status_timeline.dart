import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Visual order status timeline.
///
/// Shows the progression: Pending → Confirmed → Dispatched → Delivered.
/// Cancelled is rendered as a special terminal state with red styling.
class OrderStatusTimeline extends StatelessWidget {
  final String currentStatus;

  const OrderStatusTimeline({
    super.key,
    required this.currentStatus,
  });

  static const _steps = [
    _TimelineStep('pending', 'Pending', Icons.hourglass_empty_rounded),
    _TimelineStep('confirmed', 'Confirmed', Icons.check_circle_outline_rounded),
    _TimelineStep('dispatched', 'Dispatched', Icons.local_shipping_outlined),
    _TimelineStep('delivered', 'Delivered', Icons.inventory_2_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final isCancelled = currentStatus == 'cancelled';

    if (isCancelled) {
      return _buildCancelledTimeline(context);
    }

    return _buildNormalTimeline(context);
  }

  Widget _buildNormalTimeline(BuildContext context) {
    final currentIndex = _steps.indexWhere((s) => s.key == currentStatus);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.md,
        vertical: AppDimens.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (index) {
          // Even indices = step circles, odd indices = connectors
          if (index.isEven) {
            final stepIndex = index ~/ 2;
            final step = _steps[stepIndex];
            final isCompleted = stepIndex <= currentIndex;
            final isCurrent = stepIndex == currentIndex;
            return _buildStepCircle(step, isCompleted, isCurrent);
          } else {
            final beforeIndex = index ~/ 2;
            final isCompleted = beforeIndex < currentIndex;
            return _buildConnector(isCompleted);
          }
        }),
      ),
    );
  }

  Widget _buildCancelledTimeline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.lg,
        vertical: AppDimens.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: AppDimens.md),
          Text(
            'Order Cancelled',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(
    _TimelineStep step,
    bool isCompleted,
    bool isCurrent,
  ) {
    final color = isCompleted ? _colorForStatus(step.key) : AppColors.border;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isCurrent ? 40 : 32,
            height: isCurrent ? 40 : 32,
            decoration: BoxDecoration(
              color: isCompleted ? color : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: isCompleted ? 0 : 2,
              ),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              isCompleted ? step.icon : step.icon,
              color: isCompleted ? Colors.white : AppColors.textHint,
              size: isCurrent ? 20 : 16,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
          Text(
            step.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
              color: isCompleted ? AppColors.textPrimary : AppColors.textHint,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConnector(bool isCompleted) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Container(
          height: 2.5,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Color _colorForStatus(String status) {
    switch (status) {
      case 'pending':
        return AppColors.statusPending;
      case 'confirmed':
        return AppColors.statusConfirmed;
      case 'dispatched':
        return AppColors.statusDispatched;
      case 'delivered':
        return AppColors.statusDelivered;
      default:
        return AppColors.primary;
    }
  }
}

class _TimelineStep {
  final String key;
  final String label;
  final IconData icon;

  const _TimelineStep(this.key, this.label, this.icon);
}
