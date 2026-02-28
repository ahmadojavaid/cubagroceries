import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/image.dart';

class TabBarViewActiveCard extends StatelessWidget {
  const TabBarViewActiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Image with rating
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      welcomeImage1,
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
                    Text('Modernica Apartment', style: boldTextStyle(size: 16)),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: hintTextColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(primaryBlueColor)),
                  onPressed: () {},
                  child: Text(
                    'Details',
                    style: TextStyle(color: lightColor),
                  ),
                ),
              ),
              5.width,
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryBlueColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'E-Receipt',
                    style: secondaryTextStyle(color: primaryBlueColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
