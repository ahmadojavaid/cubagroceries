import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../store/activity_level_store.dart';
import '../../utils/colors.dart';
import 'profile_screen.dart';

class ActivityLevelScreen extends StatelessWidget {
  final ActivityLevelStore store = ActivityLevelStore();

  ActivityLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: limeColor,
            size: 28,
          ),
          onPressed: () {
            finish(context);
          },
        ),
        title: Text("Back", style: primaryTextStyle(color: limeColor)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.height,
          Text(
            "Physical Activity Level",
            style: boldTextStyle(size: 24, color: Colors.white),
          ),
          40.height,
          Text(
            "Select your current activity level to personalize workout intensity and progress tracking.",
            style: secondaryTextStyle(size: 14, color: Colors.white54),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 16),
          50.height,
          activityButton("Beginner", limeColor, Colors.black).paddingSymmetric(horizontal: 16),
          30.height,
          activityButton("Intermediate", limeColor, Colors.black).paddingSymmetric(horizontal: 16),
          30.height,
          activityButton("Advance", limeColor, Colors.black).paddingSymmetric(horizontal: 16),
          Spacer(),
          30.height,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
          text: "Continue",
          onPressed: () {
            ProfileScreen().launch(context);
          }).paddingOnly(bottom: 50),
    );
  }

  Widget activityButton(String title, Color bgColor, Color textColor) {
    return Observer(
      builder: (_) => GestureDetector(
        onTap: () => store.setSelectedLevel(title),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: store.selectedLevel == title ? bgColor : buttonColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: boldTextStyle(
                size: 18,
                color: store.selectedLevel == title ? textColor : purpleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
