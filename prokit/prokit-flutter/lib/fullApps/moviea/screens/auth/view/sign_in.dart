import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/moviea/screens/auth/view/sign_up.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../../dashboard/view/dashboard_screen.dart';

class SignInPageScreen extends StatefulWidget {
  const SignInPageScreen({super.key});

  @override
  State<SignInPageScreen> createState() => _SignInPageScreenState();
}

class _SignInPageScreenState extends State<SignInPageScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController mobileCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode mobileFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.network(logoGif, height: 100, width: 100, fit: BoxFit.cover).center().paddingOnly(top: 16),
                  16.height,
                  Text("Welcome Back", style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                  8.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Log in to your account using email or social networks",
                      style: boldTextStyle(color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  16.height,
                  AppButton(
                    elevation: 0,
                    width: context.width(),
                    color: Colors.white,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.black26),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3, left: 70),
                          child: Icon(Icons.apple),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Login With Apple",
                              style: boldTextStyle(size: 18, color: Colors.black54),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                      ],
                    ),
                    onTap: () async {
                      hideKeyboard(context);
                    },
                  ),
                  16.height,
                  AppButton(
                    elevation: 0,
                    width: context.width(),
                    color: Colors.white,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.black26),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 70),
                          child: GoogleLogoWidget(size: 20),
                        ),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Login With Google",
                                style: boldTextStyle(size: 18, color: Colors.black54),
                                textAlign: TextAlign.start,
                              ),
                            ))
                      ],
                    ),
                    onTap: () async {
                      hideKeyboard(context);
                    },
                  ),
                  20.height,
                  Row(
                    children: [
                      const Divider(color: Colors.black12).expand(),
                      8.width,
                      Text("Or continue with social account ", style: boldTextStyle(color: Colors.black26)),
                      8.width,
                      const Divider(color: Colors.black12).expand(),
                    ],
                  ),
                  20.height,
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          isValidationRequired: false,
                          textFieldType: TextFieldType.PHONE,
                          controller: mobileCont,
                          focus: mobileFocus,
                          nextFocus: passwordFocus,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          decoration: inputDecoration(context, hint: "Mobile Number"),
                        ),
                        16.height,
                        AppTextField(
                          isValidationRequired: false,
                          controller: passwordCont,
                          textFieldType: TextFieldType.PASSWORD,
                          focus: passwordFocus,
                          decoration: inputDecoration(context, hint: "Password"),
                          autoFillHints: const [AutofillHints.password],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        hideKeyboard(context);
                      },
                      child: const Text(
                        "Forgot Password ?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  10.height,
                  AppButton(
                    elevation: 0,
                    width: context.width(),
                    color: movieaPrimaryColor,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onTap: () {
                      hideKeyboard(context);
                      const DashboardScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    child: Text("Login", style: boldTextStyle(color: white)),
                  ),
                  12.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't have an account?", style: secondaryTextStyle()),
                      TextButton(
                        onPressed: () {
                          hideKeyboard(context);
                          const SignUpPageScreen().launch(context);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
