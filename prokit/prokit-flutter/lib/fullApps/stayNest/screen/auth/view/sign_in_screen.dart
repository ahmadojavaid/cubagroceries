import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/auth/view/forget_screen.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/auth/view/sign_up_screen.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../page_slider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = false;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.circle_outlined,
                        color: stayNestPrimaryColor,
                        size: screenWidth * 0.08,
                      ),
                    ),
                    TextSpan(
                      text: "live Green",
                      style: primaryTextStyle(
                        size: (screenWidth * 0.06).toInt(),
                        color: stayNestPrimaryColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Let’s get you Login!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Enter your information below",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                children: [
                  Expanded(
                    child: socialButton(
                      "Google",
                      google,
                      () {},
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: socialButton(
                      "Facebook",
                      facebook,
                      () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                    ),
                    child: Text(
                      "Or login with",
                      style: appStore.isDarkModeOn ? TextStyle(color: whiteColor, fontSize: 14) : secondaryTextStyle(),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              CustomTextField(
                label: 'Email Address',
                hintText: 'curtis.weaver@example.com',
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomTextField(
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: obscurePassword,
                toggleObscure: togglePasswordVisibility,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    hideKeyboard(context);
                    ForgotPasswordScreen().launch(context);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: secondaryTextStyle(color: stayNestPrimaryColor),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    hideKeyboard(context);
                    PageSlider().launch(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: stayNestPrimaryColor,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Login",
                    style: primaryTextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: appStore.isDarkModeOn ? TextStyle(color: whiteColor, fontSize: 14) : secondaryTextStyle(),
                  ),
                  InkWell(
                    onTap: () {
                      hideKeyboard(context);

                      RegisterScreen().launch(context);
                    },
                    child: Text(
                      "Register Now",
                      style: secondaryTextStyle(color: stayNestPrimaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialButton(String text, String icon, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: appStore.isDarkModeOn ? black : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 30, width: 30),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: appStore.isDarkModeOn ? whiteColor : stayNestPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
