import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../resources/list_wheel_view.dart';
import '../../store/age_store.dart';
import '../../utils/colors.dart';
import 'weight_selection.dart';

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({super.key});

  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  final int minAge = 18;
  final int maxAge = 100;
  final double itemWidth = 60.0;

  final AgeStore ageStore = AgeStore();

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: limeColor, size: 28),
          onPressed: () => finish(context),
        ),
        title: Text("Back", style: primaryTextStyle(color: limeColor)),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.height,
            Text(
              "How Old Are You?",
              style: boldTextStyle(size: 24, color: Colors.white),
            ),
            36.height,
            Text(
              "Select your age to help us tailor recommendations based on your fitness level and health needs.",
              style: secondaryTextStyle(color: Colors.white70, size: 14),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 16),
            40.height,
            Observer(
              builder: (_) {
                return Text(
                  "${ageStore.selectedHeight.toInt()}",
                  style: boldTextStyle(size: 35, color: Colors.white),
                );
              },
            ),
            8.height,
            Icon(Icons.arrow_drop_up, color: limeColor, size: 28),
            16.height,
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  color: primaryColor,
                ),
                Positioned(
                  left: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - itemWidth / 2,
                  right: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - itemWidth / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 2, height: 40, color: Colors.white),
                      Container(width: 2, height: 40, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Observer(
                    builder: (_) {
                      return ListWheelScrollViewX(
                        scrollDirection: Axis.horizontal,
                        itemExtent: 50,
                        onSelectedItemChanged: (index) => ageStore.selectedHeight = 18 + index.toDouble(),
                        children: List.generate(
                          90,
                              (index) =>
                              Center(
                                child: Text(
                                  '${18 + index}',
                                  style: boldTextStyle(
                                    size: 30,
                                    color: index + 18 == ageStore.selectedHeight ? Colors.white : Colors.white54,
                                  ),
                                ),
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            40.height,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        text: "Continue",
        onPressed: () {
          WeightSelectionScreen().launch(context);
        },
      ).paddingOnly(bottom: 50),
    );
  }
}
