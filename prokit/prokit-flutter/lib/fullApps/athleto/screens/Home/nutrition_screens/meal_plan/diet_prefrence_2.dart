import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../component/custom_Appbar.dart';
import '../../../../component/custom_button.dart';
import '../../../../utils/colors.dart';
import 'meal_plans.dart';

class CaloricGoalScreen extends StatefulWidget {
  const CaloricGoalScreen({super.key});

  @override
  _CaloricGoalScreenState createState() => _CaloricGoalScreenState();
}

class _CaloricGoalScreenState extends State<CaloricGoalScreen> {
  String? selectedCaloricGoal;
  String? selectedCookingTime;
  String? selectedServings;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingValue = 16;
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
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Caloric Goal
              Text('Caloric Goal', style: boldTextStyle(color: Colors.yellow, size: 18)).paddingSymmetric(horizontal: paddingValue),
              SizedBox(height: screenHeight * 0.01),
              Text('What is your daily caloric intake goal?', style: secondaryTextStyle(color: Colors.white)).paddingSymmetric(horizontal: paddingValue),
              SizedBox(height: screenHeight * 0.02),
              ...['Less than 1500 calories', '1500-2000 calories', 'More than 2000 calories', 'Not sure/Don’t have a goal']
                  .map((e) => RadioListTile(
                        value: e,
                        groupValue: selectedCaloricGoal,
                        onChanged: (val) => setState(() => selectedCaloricGoal = val.toString()),
                        title: Text(e, style: primaryTextStyle(color: Colors.white)),
                        activeColor: purpleColor,
                      ))
                  .toList(),
              SizedBox(height: screenHeight * 0.03),

              Text('Cooking Time Preference', style: boldTextStyle(color: Colors.yellow, size: 18)).paddingSymmetric(horizontal: paddingValue),
              SizedBox(height: screenHeight * 0.01),
              Text('How much time are you willing to spend cooking each meal?', style: secondaryTextStyle(color: Colors.white)).paddingSymmetric(horizontal: paddingValue),
              SizedBox(height: screenHeight * 0.02),
              ...['Less than 15 minutes', '15-30 minutes', 'More than 30 minutes']
                  .map((e) => RadioListTile(
                        value: e,
                        groupValue: selectedCookingTime,
                        onChanged: (val) => setState(() => selectedCookingTime = val.toString()),
                        title: Text(e, style: primaryTextStyle(color: Colors.white)),
                        activeColor: purpleColor,
                      ))
                  .toList(),
              SizedBox(height: 30),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
          color: limeColor,
          textcolor: blackColor,
          text: "Create",
          onPressed: () {
            BreakfastPlanScreen().launch(context);
          }).paddingOnly(bottom: 35),
    );
  }
}
