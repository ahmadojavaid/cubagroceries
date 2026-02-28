import 'dart:math';
import 'package:flutter/material.dart';

class WavyChart extends StatefulWidget {
  const WavyChart({super.key});

  @override
  State<WavyChart> createState() => _WavyChartState();
}

class _WavyChartState extends State<WavyChart> {
  late final List<Offset> wavePoints;

  @override
  void initState() {
    super.initState();
    wavePoints = generateRandomWavePoints(width: 145.5, height: 113.4);
  }

  List<Offset> generateRandomWavePoints({
    required double width,
    required double height,
  }) {
    final random = Random(42); // Use a seed for reproducibility
    final int segments = 8;
    final double stepX = width / segments;
    final double maxY = height * 0.4;

    return List.generate(
      segments + 1,
      (i) => Offset(stepX * i, random.nextDouble() * maxY),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145.5,
      height: 113.4,
      child: CustomPaint(painter: RandomWavyPainter(wavePoints: wavePoints)),
    );
  }
}

class RandomWavyPainter extends CustomPainter {
  final List<Offset> wavePoints;
  RandomWavyPainter({required this.wavePoints});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFA89CE5), Color(0x00D9D9D9)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create rounded path with cubic curves
    final Path fillPath = Path()..moveTo(wavePoints[0].dx, wavePoints[0].dy);

    for (int i = 0; i < wavePoints.length - 1; i++) {
      final p0 = wavePoints[i];
      final p1 = wavePoints[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 3, p0.dy);
      final controlPoint2 = Offset(p0.dx + 2 * (p1.dx - p0.dx) / 3, p1.dy);
      fillPath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    // Close and fill
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Stroke on top wave only
    final Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF5040A3)
      ..strokeWidth = 2;

    final Path strokePath = Path()..moveTo(wavePoints[0].dx, wavePoints[0].dy);

    for (int i = 0; i < wavePoints.length - 1; i++) {
      final p0 = wavePoints[i];
      final p1 = wavePoints[i + 1];
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 3, p0.dy);
      final controlPoint2 = Offset(p0.dx + 2 * (p1.dx - p0.dx) / 3, p1.dy);
      strokePath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p1.dx,
        p1.dy,
      );
    }

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
