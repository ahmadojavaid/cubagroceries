import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../utils/image.dart';
import 'gender_selection.dart';

class MotivationScreen extends StatelessWidget {
  const MotivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            //TODO:
            child: Image.network(
              mainImage,
              width: context.width(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            color: Colors.black,
            child: Column(
              children: [
                Text(
                  'Consistency Is\nThe Key To Progress.\nDon\'t Give Up!',
                  textAlign: TextAlign.center,
                  style: boldTextStyle(color: Colors.yellowAccent, size: 32),
                ),
                // 4.height,
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // color: Color(0xFF896CFE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Fitness isn’t a destination, it’s a lifelong journey of self-love, self-care and self-discovery.',
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle(color: Colors.white, size: 16),
                  ),
                ),
                88.height,
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        onPressed: () {
          GenderSelectionScreen().launch(context);
        },
        text: "Next",
      ).paddingOnly(bottom: 50),
    );
  }
}
