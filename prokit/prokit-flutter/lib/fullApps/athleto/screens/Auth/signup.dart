import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/custom_sign.dart';
import '../../component/custom_texfield.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';
import '../setup/main_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
            icon: Icon(Icons.arrow_back, color: limeColor, size: width * 0.07),
            onPressed: () {
              hideKeyboard(context);
              finish(context);
            }),
        title: Text("Create Account", style: boldTextStyle(size: 22, color: limeColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              50.height,
              Text("Let's Start!", style: boldTextStyle(size: 25, color: Colors.white)),
              22.height,
              34.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Full name", style: primaryTextStyle(color: Colors.white, size: 18)),
              ).paddingOnly(left: 8),
              6.height,
              CustomTextField(hintText: "Full Name", controller: emailController),
              20.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email ", style: primaryTextStyle(color: Colors.white, size: 18)),
              ).paddingOnly(left: 8),
              6.height,
              CustomTextField(
                hintText: "Email",
                imageIcon: 'images/athleto/icons/mail.png',
              ),
              20.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: primaryTextStyle(color: Colors.white, size: 18)),
              ).paddingOnly(left: 8),
              6.height,
              CustomTextField(
                hintText: "Password",
                isPassword: true,
                textFieldType: TextFieldType.PASSWORD,
              ),
              20.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password", style: primaryTextStyle(color: Colors.white, size: 18)),
              ).paddingOnly(left: 8),
              6.height,
              CustomTextField(
                hintText: "Confirm Password",
                isPassword: true,
                textFieldType: TextFieldType.PASSWORD,
              ),
              30.height,
              Text(
                "By continuing , you agree to ",
                style: primaryTextStyle(color: Colors.white, size: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Terms of Use ",
                      style: primaryTextStyle(color: limeColor, size: 18),
                    ),
                  ),
                  Text(
                    "and",
                    style: primaryTextStyle(color: white, size: 18),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      " Privacy Policy",
                      style: primaryTextStyle(color: limeColor, size: 18),
                    ),
                  ),
                ],
              ),
              30.height,
              CustomButton(
                onPressed: () {
                  hideKeyboard(context);
                  MotivationScreen().launch(context);
                },
                text: "Sign Up",
              ),
              17.height,
              Text(
                "or sign up with ",
                style: primaryTextStyle(color: Colors.white, size: 18),
              ),
              17.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  SocialButton(image: googleIcon, onPressed: () {}),
                  SocialButton(image: facebookIcon, onPressed: () {}),
                  SocialButton(
                    image: twitterIcon,
                    onPressed: () {},
                    color: white,
                  ),
                ],
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: width * 0.04, color: Colors.grey),
                  ),
                  5.width,
                  TextButton(
                      onPressed: () {
                        hideKeyboard(context);
                        AuthScreen().launch(context);
                      },
                      child: Text(
                        "Login ",
                        style: primaryTextStyle(color: limeColor, size: 18),
                      )),
                  20.height,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
