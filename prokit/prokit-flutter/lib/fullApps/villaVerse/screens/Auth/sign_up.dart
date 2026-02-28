// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';
import '../setup/profile_fill.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SingUpState();
}

class _SingUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  String svgImage = '''<img src="/dist/assets/svg/illustration-1.svg" role="img" alt>''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: appStore.isDarkModeOn ? lightColor : darkColor,
            )),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              15.height,
              Image.network(
                loginImage,
                height: context.height() * .3,
              ),
              16.height,
              Text("Create new Account", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              16.height,
              EmailTextField("Email", "Email", emailController),
              16.height,
              PasswordTextField("Password", "Password", passwordController),
              16.height,
              PasswordTextField("Conform Password", "Conform Password", conformPasswordController),
              16.height,
              AppButton(
                text: 'Continue',
                color: primaryBlueColor,
                textStyle: boldTextStyle(color: lightColor),
                width: context.width(),
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
                onTap: () {
                  hideKeyboard(context);
                  ProfileFill().launch(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account?"),
                  TextButton(
                    onPressed: () {
                      emailController.clear();
                      passwordController.clear();
                      conformPasswordController.clear();
                      hideKeyboard(context);
                      finish(context);
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: primaryBlueColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget PasswordTextField(String lable, String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lable),
        5.height,
        AppTextField(
            controller: controller,
            isPassword: true,
            suffixIconColor: hintTextColor,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: hintTextColor),
                filled: true,
                fillColor: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
                hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlueColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText),
            textFieldType: TextFieldType.PASSWORD),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget EmailTextField(String lable, String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
        ),
        5.height,
        AppTextField(
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
                hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlueColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText),
            textFieldType: TextFieldType.EMAIL)
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}