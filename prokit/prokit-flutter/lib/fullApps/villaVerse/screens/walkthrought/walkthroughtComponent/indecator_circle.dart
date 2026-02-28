import 'package:flutter/material.dart';

class IndecatorCircle extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const IndecatorCircle({super.key, required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
    );
  }
}
