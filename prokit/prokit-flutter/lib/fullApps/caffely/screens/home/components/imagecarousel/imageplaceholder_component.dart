import 'package:flutter/material.dart';

class ImagePlaceholderComponent extends StatelessWidget {
  final String? imagePath;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  const ImagePlaceholderComponent({super.key, this.imagePath, this.borderRadius, this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: Image.network(imagePath!, fit: fit ?? BoxFit.contain),
    );
  }
}
