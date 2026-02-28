import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';


class ServiceItem extends StatelessWidget {
  final String imagePath;
  final String title;
  const ServiceItem({super.key, required this.imagePath, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      height: 134,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: kiviLabAppColors.white,
        boxShadow: [
          BoxShadow(
            color: kiviLabAppColors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              imagePath,
              height: 64,
              width: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          txtWidget(title, 12, FontWeight.w600, kiviLabAppColors.titleTXT),
        ],
      ),
    );
  }
}
