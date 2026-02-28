import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/my_app_bar.dart';
import '../../store/otp_resend_time.dart';
import '../../utils/colors.dart';
import '../../../../main.dart';
import 'create_new_password.dart';

class OtpVarification extends StatefulWidget {
  const OtpVarification({super.key});

  @override
  State<OtpVarification> createState() => _OtpVarificationState();
}

class _OtpVarificationState extends State<OtpVarification> {
  final OtpResendTimer otpTime = OtpResendTimer();

  @override
  void initState() {
    super.initState();
    setTime();
  }

  Future<void> setTime() async {
    await Future.delayed(1.seconds);
    if (otpTime.time > 0) {
      otpTime.time--;
      setTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'OTP Verification'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70),
          Text(
            "Code has been send to +11 9484****52",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 80),
          OtpTextField(
            crossAxisAlignment: CrossAxisAlignment.center,
            numberOfFields: 4,
            fieldWidth: size.width * .2,
            showFieldAsBox: true,
            focusedBorderColor: primaryBlueColor,
            decoration: InputDecoration(
              focusColor: Theme.of(context).colorScheme.primary,
            ),
            filled: true,
            fillColor: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
          ),
          SizedBox(height: 70),
          Observer(builder: (_) {
            return otpTime.time == 0
                ? GestureDetector(
                    onTap: () {
                      otpTime.time = 60;
                      setTime();
                    },
                    child: Text(
                      "Resend otp",
                      style: TextStyle(color: primaryBlueColor, fontWeight: FontWeight.bold),
                    ),
                  )
                : Text(
                    "Resend Code in ${otpTime.time}s",
                    style: TextStyle(fontSize: 16),
                  );
          }),
          Expanded(
            child: SizedBox(),
          ),
          AppButton(
            text: 'Continue',
            color: primaryBlueColor,
            textStyle: boldTextStyle(color: lightColor),
            width: context.width(),
            shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
            onTap: () {
              hideKeyboard(context);
              CreateNewPassword().launch(
                context,
              );
            },
          ).paddingSymmetric(horizontal: 16),
          25.height,
        ],
      ),
    );
  }
}