import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/image.dart';
import 'diet_prefernce.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

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
              mealPlanImage,
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
                    children: [
                      const Icon(Icons.restaurant_menu,
                          color: Colors.yellow, size: 24),
                      8.width,
                      Text(
                        "Meal Plans",
                        style: boldTextStyle(color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    "Discover personalized meal plans tailored to your taste and lifestyle. Eat well and feel great every day!",
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
            child: Blur(
              blur: 20,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha:0.3),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withValues(alpha:0.5)),
                ),
                child: Text(
                  "Know Your Plan",
                  style: boldTextStyle(color: Colors.white, size: 16),
                ),
              ).onTap(() {
                DietaryPreferencesScreen().launch(context);
              }, focusColor: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}
