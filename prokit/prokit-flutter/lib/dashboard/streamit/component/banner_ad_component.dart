import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';

class AdImages extends StatelessWidget {
  const AdImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 16, right: 16),
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(6),
          child: Image.network(streamITAppImages.adImage, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
