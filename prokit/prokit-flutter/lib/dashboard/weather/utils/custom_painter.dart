import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/weather/screens/home_screeen.dart';


class CustomNavBarPainter extends CustomPainter {
  final double topCurveDepth;
  final double topCurveWidthFactor;
  final double bottomBumpHeight;
  final double bottomBumpWidthFactor;
  final double cornerRadius;

  CustomNavBarPainter({
    this.topCurveDepth = 40,
    this.topCurveWidthFactor = 0.3,
    this.bottomBumpHeight = 40,
    this.bottomBumpWidthFactor = 0.6,
    this.cornerRadius = 16,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Main background paint
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          weatherAppColors.btmNavigation1, // top color
          weatherAppColors.btmNavigation2, // bottom color
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Border paint
    final borderPaint = Paint()
      ..color = Color(0x807582F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Main path
    final path = Path();

    // Top inward curve
    final double topStartX = size.width * ((1 - topCurveWidthFactor) / 2);
    final double topEndX = size.width - topStartX;

    path.moveTo(0, 0);
    path.lineTo(topStartX, 0);
    path.quadraticBezierTo(size.width / 2, topCurveDepth, topEndX, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    // Bottom bump parameters (updated bump design with reduced top width)
    final double bumpWidth = size.width * bottomBumpWidthFactor;
    final double bumpHeight = bottomBumpHeight;
    final double bumpStartX = (size.width - bumpWidth) / 2;
    final double bumpEndX = bumpStartX + bumpWidth;
    final double bumpTopWidth = bumpWidth * 0.35; // Reduced from 0.5 to 0.3 to narrow the top
    final double bumpTopLeftX = (size.width - bumpTopWidth) / 2;
    final double bumpTopRightX = bumpTopLeftX + bumpTopWidth;
    final double bumpTopY = size.height - bumpHeight;

    // Bottom bump (main shape)
    path.lineTo(bumpEndX, size.height);
    path.cubicTo(
      bumpEndX - bumpWidth * 0.15,
      size.height,
      bumpTopRightX + bumpTopWidth * 0.25,
      bumpTopY,
      bumpTopRightX,
      bumpTopY,
    );
    path.lineTo(bumpTopLeftX, bumpTopY);
    path.cubicTo(
      bumpTopLeftX - bumpTopWidth * 0.25,
      bumpTopY,
      bumpStartX + bumpWidth * 0.15,
      size.height,
      bumpStartX,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();

    // Draw main nav bar
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);

    // Bottom bump fill path
    final bumpPath = Path();
    bumpPath.moveTo(bumpEndX, size.height);
    bumpPath.cubicTo(
      bumpEndX - bumpWidth * 0.15,
      size.height,
      bumpTopRightX + bumpTopWidth * 0.25,
      bumpTopY,
      bumpTopRightX,
      bumpTopY,
    );
    bumpPath.lineTo(bumpTopLeftX, bumpTopY);
    bumpPath.cubicTo(
      bumpTopLeftX - bumpTopWidth * 0.25,
      bumpTopY,
      bumpStartX + bumpWidth * 0.15,
      size.height,
      bumpStartX,
      size.height,
    );
    bumpPath.close();

    // Custom color or gradient for bump
    final bumpFillPaint = Paint()
      ..shader = LinearGradient(
        colors: [weatherAppColors.bottombump1, weatherAppColors.bottombump2],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(bumpTopLeftX, bumpTopY, bumpTopWidth, bumpHeight));

    canvas.drawPath(bumpPath, bumpFillPaint);
  }

  @override
  bool shouldRepaint(CustomNavBarPainter oldDelegate) =>
      oldDelegate.topCurveDepth != topCurveDepth ||
      oldDelegate.topCurveWidthFactor != topCurveWidthFactor ||
      oldDelegate.bottomBumpHeight != bottomBumpHeight ||
      oldDelegate.bottomBumpWidthFactor != bottomBumpWidthFactor ||
      oldDelegate.cornerRadius != cornerRadius;
}