import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/custom_sign.dart';
import '../../component/custom_texfield.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';
import '../setup/main_screen.dart';
import 'forget_screen.dart';
import 'signup.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Use Brightness.dark if needed
        ),
        backgroundColor: scaffoldSecondaryDark,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Log In", style: boldTextStyle(size: 30, color: Colors.limeAccent)),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
              Text("Welcome", style: boldTextStyle(size: 30, color: Colors.white)),
              SizedBox(height: height * 0.02),
              Text(
                "Welcome back! Please log in to continue your fitness journey.",
                style: secondaryTextStyle(color: Colors.white70, size: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.05),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: primaryTextStyle(color: Colors.white, size: 14)),
              ),
              SizedBox(height: height * 0.01),
              CustomTextField(hintText: "Email", controller: emailController, imageIcon: mailIcon),
              SizedBox(height: height * 0.04),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: primaryTextStyle(color: Colors.white, size: 14)),
              ),
              SizedBox(height: height * 0.01),
              CustomTextField(
                hintText: "Password",
                isPassword: true,
                textFieldType: TextFieldType.PASSWORD,
              ),
              SizedBox(height: height * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => ForgetScreen().launch(context),
                  child: Text("Forget Password?", style: primaryTextStyle(color: limeColor)),
                ),
              ),
              SizedBox(height: height * 0.06),
              CustomButton(
                onPressed: () {
                  hideKeyboard(context);

                  MotivationScreen().launch(context);
                },
                text: "Login",
              ),
              SizedBox(height: height * 0.03),
              Text("Sign up with", style: primaryTextStyle(color: Colors.white)),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(image: googleIcon, onPressed: () {}),
                  SizedBox(width: width * 0.04),
                  SocialButton(image: facebookIcon, onPressed: () {}),
                  SizedBox(width: width * 0.04),
                  SocialButton(
                    image: twitterIcon,
                    onPressed: () {},
                    color: white,
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  TextButton(
                    onPressed: () {
                      hideKeyboard(context);
                      SignupScreen().launch(context);
                    },
                    child: Text("Sign Up", style: primaryTextStyle(color: limeColor)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
