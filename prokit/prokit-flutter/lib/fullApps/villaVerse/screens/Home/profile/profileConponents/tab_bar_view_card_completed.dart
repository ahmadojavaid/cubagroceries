import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/image.dart';

class TabBarViewCardCompleted extends StatelessWidget {
  const TabBarViewCardCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Image with rating
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  welcomeImage3,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 16),

          // Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modernica Apartment',
                  style: boldTextStyle(size: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Dec 23 - 27, 2022 (5 days)',
                  style: TextStyle(
                    fontSize: 12,
                    color: hintTextColor,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$150',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' / 5 days',
                      style: TextStyle(
                        fontSize: 12,
                        color: hintTextColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryBlueColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Paid',
                        style: TextStyle(
                          fontSize: 10,
                          color: lightColor,
                        ),
                      ),
                    ),
                  ],
                ),
                8.height,
                Card(
                  elevation: 00,
                  color: Color.fromRGBO(57, 120, 68, 0.9254901960784314),
                  child: Text(
                    "Completed",
                    style: TextStyle(color: lightColor),
                  ).paddingSymmetric(horizontal: 10, vertical: 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
