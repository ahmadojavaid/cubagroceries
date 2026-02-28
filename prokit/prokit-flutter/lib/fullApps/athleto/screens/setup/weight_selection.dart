import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../resources/list_wheel_view.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import 'height_selection.dart';

class WeightSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
        leading: Icon(
          Icons.arrow_back,
          color: limeColor,
          size: 28,
        ).onTap(() {
          finish(context);
        }),
        title: Text(
          "Back",
          style: secondaryTextStyle(color: Color(0xFFE2F163), size: 18),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          Text("What Is Your Weight?", style: boldTextStyle(size: 24, color: Colors.white)),
          SizedBox(height: screenHeight * 0.04),
          Text(
            "Enter your weight to get personalized diet and exercise plans that match your body type.",
            style: secondaryTextStyle(size: 14, color: Colors.white54),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: screenHeight * 0.05),
          Observer(
            builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${weightStore.selectedWeight.toInt()} ",
                  style: boldTextStyle(size:35, color: Colors.white),
                ),
                15.height,
                Text(
                  weightStore.selectedUnit,
                  style: boldTextStyle(size: 25, color: Colors.white),
                ).paddingOnly(top: screenHeight * 0.015)
              ],
            ),
          ),
          Icon(
            Icons.arrow_drop_up,
            color: limeColor,
            size: 40,
          ),
          15.height,
          Column(
            children: [
              Container(
                height: screenHeight * 0.08,
                color: primaryColor,
                child: Center(
                  child: SizedBox(
                    height: screenHeight * 0.12,
                    child: Observer(
                      builder: (_) => ListWheelScrollViewX(
                        scrollDirection: Axis.horizontal,
                        itemExtent: screenWidth * 0.12,
                        onSelectedItemChanged: (index) => weightStore.updateWeight(70 + index.toDouble()),
                        children: List.generate(
                          30,
                          (index) => Center(
                            child: Text(
                              '${70 + index}',
                              style: boldTextStyle(
                                size: (screenWidth * 0.1).toInt(),
                                color: (index + 70) == weightStore.selectedWeight ? Colors.white : Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              25.height,
            ],
          ),
          15.height,
          Observer(
            builder: (_) => Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => weightStore.updateUnit('KG'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                      decoration: BoxDecoration(
                        color: weightStore.selectedUnit == 'KG' ? purpleColor : buttonColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      ),
                      child: Text(
                        'KG',
                        style: boldTextStyle(
                          size: 20,
                          color: weightStore.selectedUnit == 'KG' ? Colors.white : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // VerticalDivider(thickness: 2, color: Colors.black),
                  GestureDetector(
                    onTap: () => weightStore.updateUnit('LB'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                      decoration: BoxDecoration(
                        color: weightStore.selectedUnit == 'LB' ? purpleColor : buttonColor,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      child: Text(
                        'LB',
                        style: boldTextStyle(
                          size: 20,
                          color: weightStore.selectedUnit == 'LB' ? Colors.white : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        text: "Continue",
        onPressed: () {
          HeightSelectionScreen().launch(context);
        },
      ).paddingOnly(bottom: 40),
    );
  }
}
