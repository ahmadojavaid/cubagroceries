import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import 'e_receipt_screen.dart';

class ComfirmPaymentScreen extends StatefulWidget {
  const ComfirmPaymentScreen({super.key});

  @override
  State<ComfirmPaymentScreen> createState() => _ComfirmPaymentScreenState();
}

class _ComfirmPaymentScreenState extends State<ComfirmPaymentScreen> {
  Future showMsg() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
          icon: Column(
            children: [
              Lottie.asset(checkDoneAnimation, repeat: false),
              SizedBox(height: 15),
              Text(
                "Congratulations!",
                style: TextStyle(fontSize: 20, color: primaryBlueColor),
              ),
              SizedBox(height: 15),
              Text(
                "Your account is ready to use you will be redirected to the home page in a few seconds",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              AppButton(
                text: 'View E-Receipt',
                color: primaryBlueColor,
                textStyle: boldTextStyle(color: lightColor),
                width: context.width(),
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
                onTap: () => EReceiptScreen().launch(
                  context,
                ),
              ),
              16.height,
              AppButton(
                elevation: 0,
                text: 'Cancel',
                color: appStore.isDarkModeOn ? hintTextColor : blueLight,
                width: context.width(),
                textColor: appStore.isDarkModeOn ? lightColor : primaryBlueColor,
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
                onTap: () => finish(context),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Enter Your PIN'),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                "Enter your PIN to confirm payment",
              ),
              SizedBox(height: 70),
              OtpTextField(
                obscureText: true,
                crossAxisAlignment: CrossAxisAlignment.center,
                numberOfFields: 4,
                fieldWidth: context.width() * .2,
                showFieldAsBox: true,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).primaryColor,
                ),
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
                filled: true,
                fillColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: AppButton(
              text: 'Continue',
              color: primaryBlueColor,
              textStyle: boldTextStyle(color: lightColor),
              width: context.width(),
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
              onTap: () {
                hideKeyboard(context);
                showMsg();
              },
            ).paddingAll(16),
          )
        ],
      ),
    );
  }
}
