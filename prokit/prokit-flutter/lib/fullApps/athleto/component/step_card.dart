import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class StepsCard extends StatelessWidget {
  final String day;
  final String date;
  final String steps;
  final String duration;

  const StepsCard({
    super.key,
    required this.day,
    required this.date,
    required this.steps,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Date Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day, style: boldTextStyle(color: Colors.white, size: 14)),
              Text(date, style: boldTextStyle(color: Colors.white, size: 22)),
            ],
          ),

          // Divider
          Container(
            height: 30,
            width: 1,
            color: Colors.white54,
          ),

          // Steps Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Steps', style: secondaryTextStyle(color: white, size: 14)),
              Text(steps, style: boldTextStyle(color: Colors.white, size: 24)),
            ],
          ),

          // Duration Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Duration', style: secondaryTextStyle(color: white, size: 14)),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 15),
                  4.width,
                  Text(duration, style: boldTextStyle(color: Colors.white, size: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
