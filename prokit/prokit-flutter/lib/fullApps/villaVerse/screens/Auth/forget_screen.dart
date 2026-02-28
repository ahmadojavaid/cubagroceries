import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main.dart';
import '../../component/my_app_bar.dart';
import '../../store/contact_detail_selection.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';
import 'Authcomponent/forgot_contect_selection.dart';
import 'otp_varification.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final ContactDetailSelection contactStore = ContactDetailSelection();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Forgot Password'),
      body: ListView(
        children: [
          SizedBox(
            height: context.height() * .45,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                appStore.isDarkModeOn ? forgotImageDark : forgotImageLight,
                height: size.height * .4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Select which contact detail should we use to reset your password", style: TextStyle(fontSize: 12)),
          ),
          Observer(builder: (_) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    contactStore.index = 0;
                  },
                  child: ForgotContectSelection(
                    backGroundColor: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
                    icon: Icons.message,
                    height: size.height * .09,
                    toptext: "vai SMS:",
                    bottomtext: "+11 9484****52",
                    containerColor: contactStore.index == 0 ? primaryBlueColor : hintTextColor,
                    borderColor: contactStore.index == 0 ? primaryBlueColor : Colors.transparent,
                  ).paddingSymmetric(horizontal: 16),
                ),
                16.height,
                GestureDetector(
                  onTap: () {
                    contactStore.index = 1;
                  },
                  child: ForgotContectSelection(
                    backGroundColor: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
                    icon: Icons.email_rounded,
                    height: size.height * .09,
                    toptext: "vai Email:",
                    containerColor: contactStore.index == 1 ? primaryBlueColor : hintTextColor,
                    bottomtext: "roc*****el@gmail.com",
                    borderColor: contactStore.index == 1 ? primaryBlueColor : Colors.transparent,
                  ).paddingSymmetric(horizontal: 16),
                )
              ],
            );
          }),
          16.height,
          AppButton(
            text: 'Continue',
            color: primaryBlueColor,
            textStyle: boldTextStyle(color: lightColor),
            width: context.width(),
            shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
            onTap: () => OtpVarification().launch(context),
          ).paddingSymmetric(horizontal: 16),
          25.height,
        ],
      ),
    );
  }
}