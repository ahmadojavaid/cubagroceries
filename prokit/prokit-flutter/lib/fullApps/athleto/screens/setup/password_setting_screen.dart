import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/custom_texfield.dart';
import '../../utils/colors.dart';

class PasswordSettingsScreen extends StatelessWidget {
  const PasswordSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Use Brightness.dark if needed
        ),
        backgroundColor: scaffoldSecondaryDark,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: limeColor,
          size: 28,
        ).onTap(() {
          finish(context);
        }),
        title: Text("Password Settings", style: boldTextStyle(color: limeColor, size: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Password",
              style: boldTextStyle(size: 18, color: primaryColor),
            ).paddingLeft(10),
            5.height,
            CustomTextField(
              hintText: "Current Password",
              isPassword: true,
              textFieldType: TextFieldType.PASSWORD,
            ),
            30.height,
            Text(
              "New Password",
              style: boldTextStyle(size: 18, color: primaryColor),
            ).paddingLeft(10),
            5.height,
            CustomTextField(
              hintText: "New Password",
              isPassword: true,
              textFieldType: TextFieldType.PASSWORD,
            ),
            30.height,
            Text(
              "Confirm New Password",
              style: boldTextStyle(size: 18, color: primaryColor),
            ).paddingLeft(10),
            5.height,
            CustomTextField(
              hintText: "Confirm New Password",
              isPassword: true,
              textFieldType: TextFieldType.PASSWORD,
            ),
          ],
        ).paddingAll(16),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        color: limeColor,
        textcolor: black,
        text: "Change Password",
        onPressed: () {
          finish(context);
        },
      ).paddingOnly(bottom: 50),
    );
  }

  Widget passwordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: primaryTextStyle(color: Colors.white, size: 18)),
        5.height,
        AppTextField(
          textFieldType: TextFieldType.PASSWORD,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            suffixIcon: Icon(Icons.visibility, color: Colors.white54),
          ),
        ),
        15.height,
      ],
    );
  }
}
