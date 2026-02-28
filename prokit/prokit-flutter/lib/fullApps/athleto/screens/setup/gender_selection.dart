import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/gender_card.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';
import 'age_selection.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String selectedGender = "Male";

  // final StepController stepController = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
          icon: Icon(
            Icons.arrow_back,
            color: limeColor,
            size: 28,
          ),
          onPressed: () => finish(context),
        ),
        title: Text("Back", style: primaryTextStyle(color: limeColor)),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.height,
          Text(
            "What's Your Gender?",
            style: boldTextStyle(color: Colors.white, size: 24),
            textAlign: TextAlign.center,
          ).paddingOnly(left: 35),
          Text(
            "Choose your gender so we can customize your fitness journey.",
            style: secondaryTextStyle(
              color: Colors.white70,
              size: 14,
            ),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: height * 0.18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GenderCard(
                imagePath: maleImage,
                gender: "Male",
                isSelected: selectedGender == "Male",
                onTap: () {
                  setState(() {
                    selectedGender = "Male";
                  });
                },
              ),
              30.width,
              GenderCard(
                imagePath: femaleImage,
                gender: "Female",
                isSelected: selectedGender == "Female",
                onTap: () {
                  setState(() {
                    selectedGender = "Female";
                  });
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        text: "Next",
        onPressed: (() {
          AgeSelectionScreen().launch(context);
        }),
      ).paddingOnly(bottom: height * 0.05),
    );
  }
}
