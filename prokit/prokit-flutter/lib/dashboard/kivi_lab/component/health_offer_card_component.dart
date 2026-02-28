import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';


class HealthOfferCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const HealthOfferCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kiviLabAppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                txtWidget(subtitle, 10, FontWeight.w400, kiviLabAppColors.constWhite),
                const SizedBox(height: 6),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kiviLabAppColors.constWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    txtWidget("Book Now", 14, FontWeight.w600, kiviLabAppColors.constWhite),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_right_alt, color: kiviLabAppColors.constWhite),
                  ],
                ),
              ],
            ),
          ),
          Image.network(imagePath, height: 155, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
