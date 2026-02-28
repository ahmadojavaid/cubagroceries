import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/moviea/screens/auth/view/sign_in.dart';

import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';
import '../components/email_verify_dialog_component.dart';

class SignUpPageScreen extends StatefulWidget {
  const SignUpPageScreen({super.key});

  @override
  State<SignUpPageScreen> createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(logoGif, height: 100, width: 100, fit: BoxFit.cover).center().paddingOnly(top: 16),
              Text("Create New Account", style: boldTextStyle(size: LABEL_TEXT_SIZE)).paddingOnly(top: 16),
              Text("Set up your username and password. You can always change it later.", style: boldTextStyle(color: Colors.black26), textAlign: TextAlign.center).paddingOnly(top: 16, left: 16, right: 16),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      isValidationRequired: false,
                      controller: firstNameCont,
                      focus: firstNameFocus,
                      nextFocus: mobileFocus,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(context, hint: "Full name"),
                    ),
                    AppTextField(
                      isValidationRequired: false,
                      controller: mobileCont,
                      focus: mobileFocus,
                      nextFocus: emailFocus,
                      textFieldType: TextFieldType.PHONE,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: inputDecoration(context, hint: "Mobile Number"),
                    ).paddingOnly(top: 16),
                    AppTextField(
                      isValidationRequired: false,
                      controller: emailCont,
                      focus: emailFocus,
                      nextFocus: passwordFocus,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(context, hint: "Email"),
                    ).paddingOnly(top: 16),
                    AppTextField(
                      isValidationRequired: false,
                      controller: passwordCont,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: passwordFocus,
                      decoration: inputDecoration(context, hint: "Password"),
                    ).paddingOnly(top: 16),
                  ],
                ),
              ).paddingOnly(top: 16),
              AppButton(
                elevation: 0,
                width: context.width(),
                color: Colors.red,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onTap: () async {
                  hideKeyboard(context);
                  showDialog(
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: const EmailVerifyDialogComponent(),
                    ),
                  );
                },
                child: Text("Signup", style: boldTextStyle(color: white)),
              ).paddingOnly(top: 16),
              42.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: secondaryTextStyle()),
                  TextButton(
                    onPressed: () {
                      hideKeyboard(context);
                      const SignInPageScreen().launch(context);
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
