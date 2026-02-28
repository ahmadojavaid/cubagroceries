import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/custom_texfield.dart';
import '../../utils/colors.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  SetPasswordScreen({super.key});

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
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              hideKeyboard(context);
              finish(context);
            },
            icon: Icon(Icons.arrow_left, color: limeColor)),
        title: Text("Set Password", style: boldTextStyle(size: 22, color: limeColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text("Set Password?", style: boldTextStyle(size: 25, color: Colors.white)),
              ),
              34.height,
              Text(
                "Create a secure password to protect your account. Make sure it's at least 8 characters long and includes a mix of letters, numbers, and symbols.",
                style: secondaryTextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              34.height,
              Align(alignment: Alignment.centerLeft, child: Text("Password")),
              6.height,
              CustomTextField(
                hintText: "Password",
                textFieldType: TextFieldType.PASSWORD,
                isPassword: true,
              ),
              20.height,
              Align(alignment: Alignment.centerLeft, child: Text("Confirm Password")),
              6.height,
              CustomTextField(
                hintText: "Confirm Password",
                textFieldType: TextFieldType.PASSWORD,
                isPassword: true,
              ),
              60.height,
              CustomButton(
                onPressed: () {
                  hideKeyboard(context);
                  AuthScreen().launch(context);
                },
                text: "Reset Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
