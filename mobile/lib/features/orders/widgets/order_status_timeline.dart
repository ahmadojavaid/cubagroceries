import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Visual order status timeline with a pulsing animation on the active step.
///
/// Shows the progression: Pending → Confirmed → Dispatched → Delivered.
/// The current (active) step icon pulses to indicate an in-progress task.
/// Cancelled is rendered as a special terminal state with red styling.
class OrderStatusTimeline extends StatefulWidget {
  final String currentStatus;

  const OrderStatusTimeline({
    super.key,
    required this.currentStatus,
  });

  @override
  State<OrderStatusTimeline> createState() => _OrderStatusTimelineState();
}

class _OrderStatusTimelineState extends State<OrderStatusTimeline>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  static const _steps = [
    _TimelineStep('pending', 'Pending', Icons.hourglass_empty_rounded),
    _TimelineStep('confirmed', 'Confirmed', Icons.check_circle_outline_rounded),
    _TimelineStep('dispatched', 'Dispatched', Icons.local_shipping_outlined),
    _TimelineStep('delivered', 'Delivered', Icons.inventory_2_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Only pulse for non-terminal states
    if (widget.currentStatus != 'delivered' &&
        widget.currentStatus != 'cancelled') {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(OrderStatusTimeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStatus != widget.currentStatus) {
      if (widget.currentStatus == 'delivered' ||
          widget.currentStatus == 'cancelled') {
        _pulseController.stop();
        _pulseController.reset();
      } else if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCancelled = widget.currentStatus == 'cancelled';

    if (isCancelled) {
      return _buildCancelledTimeline();
    }

    return _buildNormalTimeline();
  }

  Widget _buildNormalTimeline() {
    final currentIndex =
        _steps.indexWhere((s) => s.key == widget.currentStatus);

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

  Widget _buildCancelledTimeline() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.lg,
        vertical: AppDimens.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
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
          const Text(
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
    final isTerminal = widget.currentStatus == 'delivered';
    final shouldPulse = isCurrent && !isTerminal;

    Widget circle = Container(
      width: isCurrent ? 40 : 32,
      height: isCurrent ? 40 : 32,
      decoration: BoxDecoration(
        color: isCompleted ? color : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: isCompleted ? 0 : 2,
        ),
      ),
      child: Icon(
        step.icon,
        color: isCompleted ? Colors.white : AppColors.textHint,
        size: isCurrent ? 20 : 16,
      ),
    );

    if (shouldPulse) {
      circle = AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: _glowAnimation.value),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                step.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          );
        },
      );
    } else if (isCurrent && isTerminal) {
      // Delivered — static glow, no pulse
      circle = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          step.icon,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    return SizedBox(
      width: 64,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circle,
          const SizedBox(height: AppDimens.xs),
          Text(
            step.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
              color: isCompleted ? AppColors.textPrimary : AppColors.textHint,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
