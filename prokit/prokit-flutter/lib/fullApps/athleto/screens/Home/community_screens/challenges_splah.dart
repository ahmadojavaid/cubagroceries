import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import 'challenges_a.dart';

class CyclingChallengeScreen extends StatelessWidget {
  final String title;
  final String image;
  CyclingChallengeScreen({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: Stack(
        children: [
          Positioned.fill(
            //TODO:
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 100,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.directions_bike,
                          color: Colors.yellow, size: 24),
                      8.width,
                      Text(
                        title,
                        style: boldTextStyle(color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
                    style: secondaryTextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha:0.3),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha:0.5)),
              ),
              child: Text(
                "Start Now",
                style: boldTextStyle(color: Colors.white, size: 16),
              ),
            ).onTap(() {
              ChallengesAScreen().launch(context);
            }),
          ),
        ],
      ),
    );
  }
}
