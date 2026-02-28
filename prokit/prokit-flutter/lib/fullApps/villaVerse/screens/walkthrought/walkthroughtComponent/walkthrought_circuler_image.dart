import 'dart:math' as math;

import 'package:flutter/material.dart';

class WalkthroughtCirculerImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final double rotate;

  const WalkthroughtCirculerImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.rotate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.skewX(.0)..rotateZ(-math.pi / rotate),
            child: Image.network(image),
          ),
        ),
      ),
    );
  }
}
