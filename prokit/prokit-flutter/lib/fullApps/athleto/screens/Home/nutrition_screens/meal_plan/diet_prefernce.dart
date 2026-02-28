import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../component/custom_Appbar.dart';
import '../../../../component/custom_button.dart';
import '../../../../utils/colors.dart';
import '../nutritent_screens.dart';
import 'diet_prefrence_2.dart';

class DietaryPreferencesScreen extends StatefulWidget {
  const DietaryPreferencesScreen({super.key});

  @override
  _DietaryPreferencesScreenState createState() => _DietaryPreferencesScreenState();
}

class _DietaryPreferencesScreenState extends State<DietaryPreferencesScreen> {
  String? selectedDietPreference = "No preferences";
  String? selectedAllergy = "Nuts";
  String? selectedMealType = "Breakfast";

  List<String> dietPreferences = ['Vegetarian', 'Keto', 'Vegan', 'Paleo', 'Gluten-Free', 'No preferences'];
  List<String> allergies = ['Nuts', 'Eggs', 'Dairy', 'No allergies', 'Shellfish'];
  List<String> mealTypes = ['Breakfast', 'Dinner', 'Lunch', 'Snacks'];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double padding = screenWidth * 0.05;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Meal Plans",
        onBack: () {
          NutritentScreens().launch(context);
        },
      ),
      body: WillPopScope(
          onWillPop: () async {
            NutritentScreens().launch(context, isNewTask: true);
            return true;
          },
          child: SafeArea(
              child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: padding, vertical: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle("Dietary Preferences"),
                      descriptionText("What are your dietary preferences?"),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: screenWidth * 0.02,
                        runSpacing: screenHeight * 0.01,
                        children: dietPreferences.map((e) {
                          return selectionOption(e, selectedDietPreference == e, () {
                            setState(() => selectedDietPreference = e);
                          });
                        }).toList(),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      sectionTitle("Allergies"),
                      descriptionText("Do you have any food allergies we should know about?"),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: screenWidth * 0.02,
                        runSpacing: screenHeight * 0.01,
                        children: allergies.map((e) {
                          return selectionOption(e, selectedAllergy == e, () {
                            setState(() => selectedAllergy = e);
                          });
                        }).toList(),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      sectionTitle("Meal Types"),
                      descriptionText("Which meals do you want to plan?"),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: screenWidth * 0.02,
                        runSpacing: screenHeight * 0.01,
                        children: mealTypes.map((e) {
                          return selectionOption(e, selectedMealType == e, () {
                            setState(() => selectedMealType = e);
                          });
                        }).toList(),
                      ),
                      SizedBox(height: screenHeight * 0.06),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.03),
                  child: CustomButton(
                    color: limeColor,
                    textcolor: blackColor,
                    text: "Next",
                    onPressed: () {
                      CaloricGoalScreen().launch(context);
                    },
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  Widget sectionTitle(String title) {
    return Text(title, style: boldTextStyle(color: limeColor, size: 18));
  }

  Widget descriptionText(String text) {
    return Text(text, style: primaryTextStyle(color: Colors.white54, size: 14));
  }

  Widget selectionOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: isSelected ? Color(0xFF896CFE) : Colors.white30, width: 2),
          color: isSelected ? Colors.black : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Color(0xFF896CFE) : Colors.white54,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(text, style: primaryTextStyle(color: Colors.white, size: 14)),
          ],
        ),
      ),
    );
  }
}
