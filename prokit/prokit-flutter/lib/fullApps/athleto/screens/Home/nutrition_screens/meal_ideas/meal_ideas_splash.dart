import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/image.dart';
import 'meal_idea_a.dart';

class MealIdeasScreen extends StatelessWidget {
  const MealIdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: Stack(
        children: [
          //TODO:
          Positioned.fill(
            child: Image.network(
              mealIdeasImage,
              fit: BoxFit.cover,
            ),
          ),

          // Meal Ideas Card
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
                    children: [
                      const Icon(Icons.restaurant,
                          color: Colors.yellow, size: 24),
                      8.width,
                      Text(
                        "Meal Ideas",
                        style: boldTextStyle(color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    "Discover personalized meal ideas tailored to your taste and lifestyle. Eat well and feel great every day!",
                    style: secondaryTextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Discover Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Blur(
              blur: 30,
              borderRadius: BorderRadius.circular(30),
              child: GestureDetector(
                  onTap: () {
                    MealIdeaAScreen().launch(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      "Discover",
                      style: boldTextStyle(color: Colors.white, size: 16),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
