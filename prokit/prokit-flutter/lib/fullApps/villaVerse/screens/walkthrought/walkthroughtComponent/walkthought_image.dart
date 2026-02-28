import 'package:flutter/material.dart';

class WalkthoughtImage extends StatelessWidget {
  final String imgPath;
  final double height;
  final double width;

  const WalkthoughtImage({super.key, required this.imgPath, required this.height, required this.width,});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(500),
        topRight: Radius.circular(500),
        bottomLeft: Radius.circular(100),
        bottomRight: Radius.circular(100),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.network(
            imgPath,
          ),
        ),
      ),
    );
  }
}
