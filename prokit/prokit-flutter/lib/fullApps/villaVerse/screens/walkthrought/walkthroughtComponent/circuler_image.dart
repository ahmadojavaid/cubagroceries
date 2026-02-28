import 'package:flutter/material.dart';

class CirculerImage extends StatelessWidget {
  final double height;

  const CirculerImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(255, 122, 219, 243),
      ),
    );
  }
}
