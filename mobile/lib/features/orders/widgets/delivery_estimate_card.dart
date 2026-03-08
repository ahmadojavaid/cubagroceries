import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/order_model.dart';

/// Shows a circular countdown dial for estimated delivery time.
/// Only renders when the order is dispatched and has a valid estimate.
class DeliveryEstimateCard extends StatefulWidget {
  final OrderDetailModel order;

  const DeliveryEstimateCard({super.key, required this.order});

  @override
  State<DeliveryEstimateCard> createState() => _DeliveryEstimateCardState();
}

class _DeliveryEstimateCardState extends State<DeliveryEstimateCard>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Tick every second for smooth countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    // Only show for active orders with a delivery estimate
    if (!order.hasDeliveryEstimate) return const SizedBox.shrink();
    if (order.status != 'dispatched' && order.status != 'confirmed') {
      return const SizedBox.shrink();
    }

    final target = order.estDeliveryTime!;
    final now = DateTime.now();
    final remaining = target.difference(now);
    final isOverdue = remaining.isNegative;

    final totalSeconds = order.estDeliveryMinutes! * 60;
    final elapsedSeconds = now.difference(order.estDeliverySetAt!).inSeconds;
    final remainingSeconds = (totalSeconds - elapsedSeconds).clamp(0, totalSeconds);

    // Progress: 1.0 (full time left) → 0.0 (time's up) — reverse countdown
    final progress = isOverdue ? 0.0 : (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

    // Format remaining time
    final absRemaining = remaining.abs();
    final mins = absRemaining.inMinutes;
    final secs = absRemaining.inSeconds % 60;

    String timeText;
    String subtitleText;

    if (isOverdue) {
      timeText = mins > 0
          ? '+${mins}m ${secs.toString().padLeft(2, '0')}s'
          : '+${secs}s';
      subtitleText = 'Taking longer than expected';
    } else if (remaining.inSeconds < 60) {
      timeText = '${secs}s';
      subtitleText = 'Arriving now!';
    } else {
      timeText = mins > 59
          ? '${mins ~/ 60}h ${(mins % 60).toString().padLeft(2, '0')}m'
          : '${mins}m ${secs.toString().padLeft(2, '0')}s';
      subtitleText = 'Expected by ${_formatTime(target)}';
    }

    final primaryColor = isOverdue ? AppColors.warning : AppColors.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Icon(
                isOverdue
                    ? Icons.timer_off_outlined
                    : order.status == 'dispatched'
                        ? Icons.delivery_dining_rounded
                        : Icons.schedule_rounded,
                size: 18,
                color: primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                isOverdue
                    ? 'Delivery Delayed'
                    : order.status == 'dispatched'
                        ? 'Rider On The Way'
                        : 'Estimated Delivery Time',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimens.lg),

          // Circular countdown dial
          SizedBox(
            width: 160,
            height: 160,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) {
                final pulseOpacity = isOverdue
                    ? 0.4 + (_pulseController.value * 0.3)
                    : 1.0;

                return CustomPaint(
                  painter: _CountdownDialPainter(
                    progress: progress,
                    color: primaryColor,
                    trackOpacity: 0.12,
                    strokeWidth: 10,
                    sweepOpacity: pulseOpacity,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeText,
                          style: TextStyle(
                            fontSize: isOverdue ? 22 : 26,
                            fontWeight: FontWeight.w800,
                            color: primaryColor,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isOverdue ? 'overdue' : 'remaining',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppDimens.md),

          // Subtitle
          Text(
            subtitleText,
            style: TextStyle(
              fontSize: 13,
              color: isOverdue
                  ? AppColors.warning.withValues(alpha: 0.8)
                  : AppColors.textSecondary,
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

/// Custom painter for the circular countdown dial.
/// Draws a track circle and a sweep arc that shrinks as time runs out.
class _CountdownDialPainter extends CustomPainter {
  final double progress; // 1.0 = full, 0.0 = time's up
  final Color color;
  final double trackOpacity;
  final double strokeWidth;
  final double sweepOpacity;

  _CountdownDialPainter({
    required this.progress,
    required this.color,
    this.trackOpacity = 0.12,
    this.strokeWidth = 10,
    this.sweepOpacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Track (background circle)
    final trackPaint = Paint()
      ..color = color.withValues(alpha: trackOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Active arc (sweeps from top, clockwise)
    if (progress > 0) {
      final sweepAngle = 2 * math.pi * progress;
      final activePaint = Paint()
        ..color = color.withValues(alpha: sweepOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        -math.pi / 2, // Start from top
        sweepAngle,
        false,
        activePaint,
      );

      // Small dot at the end of the arc
      final dotAngle = -math.pi / 2 + sweepAngle;
      final dotCenter = Offset(
        center.dx + radius * math.cos(dotAngle),
        center.dy + radius * math.sin(dotAngle),
      );
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dotCenter, strokeWidth / 2 + 1, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_CountdownDialPainter old) =>
      old.progress != progress ||
      old.sweepOpacity != sweepOpacity ||
      old.color != color;
}
