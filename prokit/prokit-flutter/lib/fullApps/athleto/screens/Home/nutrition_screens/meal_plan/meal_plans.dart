import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../component/custom_Appbar.dart';
import '../../../../component/custom_button.dart';
import '../../../../component/diet_card.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../detail_nutritent.dart';

class BreakfastPlanScreen extends StatefulWidget {
  const BreakfastPlanScreen({super.key});

  @override
  _BreakfastPlanScreenState createState() => _BreakfastPlanScreenState();
}

class _BreakfastPlanScreenState extends State<BreakfastPlanScreen> {
  String? selectedMeal;

  List<Map<String, dynamic>> meals = [
    {
      "title": "Delights With Greek Yogurt",
      "time": "6 Minutes",
      "calories": "200 Cal",
      "image": "assets/images/w1.jpg",
    },
    {
      "title": "Spinach And Tomato Omelette",
      "time": "10 Minutes",
      "calories": "220 Cal",
      "image": "assets/images/w1.jpg",
    },
    {
      "title": "Avocado And Egg Toast",
      "time": "15 Minutes",
      "calories": "150 Cal",
      "image": "assets/images/w1.jpg",
    },
    {
      "title": "Protein Shake With Fruits",
      "time": "9 Minutes",
      "calories": "180 Cal",
      "image": "assets/images/w1.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Meal Plans",
        onBack: () {
          finish(context);
        },
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Breakfast Plan For You", style: boldTextStyle(color: Color(0xFFE2F163), size:20 )).paddingSymmetric(horizontal: screenWidth * 0.04),
                  SizedBox(height: screenHeight * 0.01),
                  Text("Boost your energy with these easy and healthy breakfast recipes, perfect for a fresh start to your day.", style: primaryTextStyle(color: Colors.white, size: 14)).paddingSymmetric(horizontal: 16),
                  Column(
                    children: meals.map((meal) {
                      return mealCard(meal, screenWidth);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.04),
                child: CustomButton(
                    text: "See Recipe",
                    onPressed: () {
                      RecipeDetailsScreen().launch(context);
                    })),
          ),
        ],
      )),
    );
  }

  Widget mealCard(Map<String, dynamic> meal, double screenWidth) {
    bool isSelected = selectedMeal == meal["title"];
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMeal = meal["title"];
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? purpleColor : Colors.white,
          ),
          SizedBox(width: screenWidth * 0.01),
          DietCard(
            recommadationMeal: breakfastPlanMeals,
            index: 0,
            isFavorite: true,
          ).expand()
        ],
      ).paddingAll(screenWidth * 0.01),
    );
  }
}
