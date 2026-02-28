import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/health/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/health/utils/app_colors.dart';

BoxDecoration decoratedContainerWidget() {
  return BoxDecoration(
    color: healthAppColors.white,
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: healthAppColors.boxShadow,
        offset: const Offset(0, 4),
        blurRadius: 10,
      ),
    ],
  );
}
BoxDecoration subDecoratedContainerWidget() {
  return BoxDecoration(
    color: healthAppColors.subContainer,
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: healthAppColors.boxShadow,
        offset: const Offset(0, 4),
        blurRadius: 10,
      ),
    ],
  );
}

Icon iconsWidget(IconData icon, double size, Color color) {
  return Icon(icon, size: size, color: color);
}

Widget txtWidget(String label, double size, FontWeight fontWeight, Color color) {
  return Text(
    label,
    style: GoogleFonts.roboto(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Widget dashboardCardWidget({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: healthAppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: healthAppColors.black)],
    ),
    child: child,
  );
}

class CircularStepProgressPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  CircularStepProgressPainter({
    required this.progress,
    this.backgroundColor = HealthAppColors.constGrey,
    this.progressColor = HealthAppColors.constCompletedStep,
    this.strokeWidth = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor.withAlpha((0.2 * 255).toInt())
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
