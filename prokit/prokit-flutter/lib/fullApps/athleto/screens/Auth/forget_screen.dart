import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/custom_texfield.dart';
import '../../utils/colors.dart';
import 'set_password.dart';

class ForgetScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  ForgetScreen({super.key});

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
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              hideKeyboard(context);

              finish(context);
            },
            icon: Icon(
              Icons.arrow_left,
              color: limeColor,
            )),
        title: Text("Forgetten Password", style: boldTextStyle(size: 22, color: limeColor)),
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
                child: Text("Forget Password?", style: boldTextStyle(size: 25, color: Colors.white)),
              ),
              34.height,
              Text(
                " Don’t worry! Enter your registered email, and we’ll send you a reset link.",
                style: secondaryTextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              34.height,
              Align(alignment: Alignment.centerLeft, child: Text("Enter your email address")),
              6.height,
              CustomTextField(
                hintText: "Enter email",
              ),
              30.height,
              CustomButton(
                onPressed: () {
                  hideKeyboard(context);
                  SetPasswordScreen().launch(context);
                },
                text: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
