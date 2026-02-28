import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class ProgressCard extends StatelessWidget {
  final String icon;
  final String kcal;
  final String title;
  final String date;
  final String duration;

  const ProgressCard({
    super.key,
    required this.icon,
    required this.kcal,
    required this.title,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: buttonColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: purpleColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(icon, width: 30, height: 30, color: purpleColor),
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_fire_department, size: 14, color: purpleColor),
                  4.width,
                  Text(kcal, style: secondaryTextStyle(size: 12,color: white)),
                ],
              ),
              4.height,
              Text(title, style: boldTextStyle(color: white,size:16)),
              2.height,
              Text(date, style: secondaryTextStyle(color: limeColor)),
            ],
          ).expand(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 17,
                    color: purpleColor,
                  ),
                  4.width,
                  Text(
                    'Duration',
                    style: secondaryTextStyle(
                      color: purpleColor,size: 12
                    ),
                  ),
                ],
              ),
              2.height,
              Text(
                duration,
                style: boldTextStyle(
                  size: 15,
                  color: purpleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
