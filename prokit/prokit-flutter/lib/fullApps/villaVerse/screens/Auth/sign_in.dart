import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';
import '../Home/homeScreenActions/components/bottom_navigation.dart';
import 'Authcomponent/signin_helper.dart';
import 'forget_screen.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool rememberValue = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.network(
                signInImage,
                height: context.height() * .3,
              ),
              16.height,
              Text("Login to your Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              16.height,
              AppTextField(
                textStyle: primaryTextStyle(),
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: appStore.isDarkModeOn
                      ? inputFillColorDart
                      : inputFillColorlight,
                  hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryBlueColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Email",
                ),
                textFieldType: TextFieldType.EMAIL,
              ).paddingSymmetric(horizontal: 16),
              16.height,
              AppTextField(
                textStyle: primaryTextStyle(),
                controller: passwordController,
                isPassword: true,
                suffixIconColor: hintTextColor,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: hintTextColor),
                  filled: true,
                  fillColor: appStore.isDarkModeOn
                      ? inputFillColorDart
                      : inputFillColorlight,
                  hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryBlueColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Password",
                ),
                textFieldType: TextFieldType.PASSWORD,
              ).paddingSymmetric(horizontal: 16),
              Row(
                children: [
                  Text(
                    "Remember me",
                  ),
                  Expanded(child: SizedBox()),
                  Transform.scale(
                    scale: .75,
                    child: Switch(
                      value: rememberValue,
                      inactiveTrackColor: appStore.isDarkModeOn
                          ? inputFillColorDart
                          : inputFillColorlight,
                      inactiveThumbColor: hintTextColor,
                      activeColor: primaryBlueColor,
                      trackOutlineColor:
                          WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                        return Colors.transparent;
                      }),
                      onChanged: (value) {
                        setState(() {
                          rememberValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
              AppButton(
                text: 'Continue',
                color: primaryBlueColor,
                textStyle: boldTextStyle(color: lightColor),
                width: context.width(),
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
                onTap: () => BottomNavigation().launch(context),
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      hideKeyboard(context);
                      ForgetScreen().launch(context);
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: primaryBlueColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: Container(
                      width: size.width * .18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appStore.isDarkModeOn
                              ? inputFillColorDart
                              : inputFillColorlight,
                        ),
                      ),
                    ),
                  ),
                  Text("or continue with"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: Container(
                      width: size.width * .18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appStore.isDarkModeOn
                              ? inputFillColorDart
                              : inputFillColorlight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SigninHelper(
                    height: 50,
                    imagepath: facebookIcon,
                    backgroudColor: Theme.of(context).colorScheme.surface,
                    imgColor: null,
                  ),
                  SigninHelper(
                    height: 50,
                    imagepath: googleIcon,
                    backgroudColor: Theme.of(context).colorScheme.surface,
                    imgColor: null,
                  ),
                  SigninHelper(
                    height: 50,
                    imagepath: appleIcon,
                    backgroudColor: Theme.of(context).colorScheme.surface,
                    imgColor: appStore.isDarkModeOn ? lightColor : darkColor,
                  ),
                ],
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account?"),
                  TextButton(
                    onPressed: () {
                      hideKeyboard(context);
                      SignUp().launch(context);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: primaryBlueColor),
                    ),
                  )
                ],
              ).paddingAll(16),
            ],
          ),
        ],
      ),
    );
  }
}
