import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class WorkoutCard extends StatelessWidget {
  final String image;
  final String title;
  final String duration;
  final String calories;
  final bool isFavorite;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.image,
    required this.title,
    required this.duration,
    required this.calories,
    this.isFavorite = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                //TODO:
                child: Image.network(image, height: 100, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.star, color: isFavorite ? limeColor : Colors.white24, size: 20),
              ),
            ],
          ),
          8.height,
          Text(title, style: boldTextStyle(color: limeColor, size: 14)),
          4.height,
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.white70),
              4.width,
              Text(duration, style: secondaryTextStyle(color: Colors.white70, size: 12)),
              8.width,
              Icon(Icons.local_fire_department, size: 14, color: Colors.purpleAccent),
              4.width,
              Text(calories, style: secondaryTextStyle(color: Colors.white70, size: 12)),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: purpleColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
