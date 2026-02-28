import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../utils/colors.dart';
import 'activity_level.dart';

class GoalSelectionScreen extends StatefulWidget {
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String? selectedGoal;
  List<String> goals = [
    "Lose Weight",
    "Gain Weight",
    "Muscle Mass Gain",
    "Shape Body",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(

      backgroundColor: scaffoldSecondaryDark,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Use Brightness.dark if needed
        ),
        backgroundColor: scaffoldSecondaryDark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: limeColor, size: 28),
          onPressed: () => finish(context),
        ),
        title: Text("Back", style: primaryTextStyle(color: limeColor)),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.03),
            Center(
              child: Text("What Is Your Goal?", style: boldTextStyle(size: 24, color: Colors.white)),
            ),
            SizedBox(height: height * 0.02),
            Center(
              child: Text(
                "Choose your fitness goal so we can design the best plan for you.",
                style: secondaryTextStyle(size: 14, color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.04),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = goals[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.014),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.015),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            goals[index],
                            style: boldTextStyle(color: Colors.white, size: 16),
                          ),
                          Icon(
                            selectedGoal == goals[index] ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            color: purpleColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: height * 0.05),
        child: CustomButton(
          text: "Continue",
          onPressed: () {
            ActivityLevelScreen().launch(context);
          },
        ),
      ),
    );
  }
}
