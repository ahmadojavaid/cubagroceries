import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/my_app_bar.dart';
import '../../utils/colors.dart';
import '../../../../main.dart';
import '../Home/homeScreenActions/components/bottom_navigation.dart';

class PinCreateScreen extends StatelessWidget {
  const PinCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Create New PIN'),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                "Add a PIN number to make your account",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "more secure.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 70),
              OtpTextField(
                crossAxisAlignment: CrossAxisAlignment.center,
                numberOfFields: 4,
                fieldWidth: size.width * .2,
                showFieldAsBox: true,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).primaryColor,
                ),
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
                filled: true,
                fillColor: appStore.isDarkModeOn
                    ? inputFillColorDart
                    : inputFillColorlight,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              text: 'Continue',
              color: primaryBlueColor,
              textStyle: boldTextStyle(color: Colors.white),
              width: context.width(),
              shapeBorder: RoundedRectangleBorder(
                borderRadius: radius(20),
              ),
              onTap: () => BottomNavigation().launch(context),
            ).paddingAll(16),
          )
        ],
      ),
    );
  }
}
