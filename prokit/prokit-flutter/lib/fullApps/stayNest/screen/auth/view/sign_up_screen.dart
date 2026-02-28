import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/auth/view/profile_screen.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../utils/colors.dart';
import '../components/checkbox_component.dart';
import 'sign_in_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController dobController = TextEditingController();
  String gender = 'Male';
  bool isAgreed = false;

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  bool _obscureConfirm = false;
  bool obscurePassword = false;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void togglecPasswordVisibility() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.circle_outlined,
                            color: stayNestPrimaryColor,
                            size: 30,
                          ),
                        ),
                        TextSpan(
                          text: "live Green",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: stayNestPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.height,
                  const Text(
                    "Register Now!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  8.height,
                  const Text(
                    "Enter your information below",
                    style: TextStyle(color: Colors.grey),
                  ),
                  24.height,
                  CustomTextField(label: 'Name', hintText: 'Curtis Weaver'),
                  16.height,
                  CustomTextField(
                    label: 'Email Address',
                    hintText: 'curtis.weaver@example.com',
                  ),
                  16.height,
                  CustomTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    obscureText: obscurePassword,
                    toggleObscure: togglePasswordVisibility,
                    isPassword: true,
                  ),
                  10.height,
                  CustomTextField(
                    label: 'Conform Password',
                    hintText: 'Conform password',
                    obscureText: _obscureConfirm,
                    toggleObscure: togglecPasswordVisibility,
                    isPassword: true,
                  ),
                  24.height,
                ],
              ).paddingSymmetric(horizontal: 20),
              TermsAndConditionsCheckbox(
                initialValue: isAgreed,
                onChanged: (value) {
                  setState(() {
                    isAgreed = value;
                  });
                },
              ).paddingLeft(8),
              20.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    hideKeyboard(context);

                    ProfileScreen().launch(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: stayNestPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ).paddingSymmetric(horizontal: 20),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member? "),
                  InkWell(
                    onTap: () {
                      hideKeyboard(context);

                      LoginScreen().launch(
                        context,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: stayNestPrimaryColor),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderOption(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: gender,
          activeColor: stayNestPrimaryColor,
          onChanged: (val) {
            setState(() {
              gender = val!;
            });
          },
        ),
        Text(value),
      ],
    );
  }
}
