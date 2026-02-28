import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../store/height_store.dart';
import '../../utils/colors.dart';
import 'goal_selection.dart';

class HeightSelectionScreen extends StatelessWidget {
  final HeightStore store = HeightStore();

  HeightSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.height,
                  Text(
                    "What Is Your Height?",
                    style: boldTextStyle(size: 24, color: Colors.white),
                  ),
                  35.height,
                  Text(
                    "Your height helps us calculate BMI and provide accurate fitness insights.",
                    style: secondaryTextStyle(size: 14, color: Colors.white54),
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 16),
                  20.height,

                  Observer(
                    builder: (_) => Text(
                      "${store.selectedHeight.toInt()} Cm",
                      style: boldTextStyle(size: 35, color: Colors.white),
                    ),
                  ),
                  20.height,

                  // Scrollable wheel view
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Container(
                          width: 120,
                          height: 400, // Set a fixed height
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Observer(
                            builder: (_) => ListWheelScrollView(
                              itemExtent: 50,
                              physics: FixedExtentScrollPhysics(),
                              controller: FixedExtentScrollController(initialItem: 10),
                              useMagnifier: true,
                              magnification: 1.2,
                              onSelectedItemChanged: (index) => store.updateHeight(165 + index.toDouble()),
                              children: List.generate(
                                60,
                                (index) => Center(
                                  child: Text(
                                    '${165 + index}',
                                    style: boldTextStyle(
                                      size: 30,
                                      weight: FontWeight.w800,
                                      color: (index + 165) == store.selectedHeight ? Colors.white : Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_left, size: 60, color: limeColor),
                    ],
                  ).paddingLeft(30),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.04),
                child: CustomButton(
                  text: "Continue",
                  onPressed: () {
                    GoalSelectionScreen().launch(context);
                  },
                )),
          ),
        ],
      )),
    );
  }
}
