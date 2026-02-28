import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/weather/screens/home_screeen.dart';


class WidgetImages extends StatelessWidget {
  const WidgetImages({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      weatherAppImages.widget2,
      weatherAppImages.widget3,
      weatherAppImages.widget4,
      weatherAppImages.widget5,
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(height: 158, child: Image.network(weatherAppImages.widget1)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
            children: imageList.map((imagePath) {
              return SizedBox(
                height: 164,
                width: 164,
                child: Image.network(imagePath, fit: BoxFit.cover),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 80),
      ],
    );
  }
}
