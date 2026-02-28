import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../signin/screen/singin_home_screen.dart';
import 'complete_your_profile_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccountScreen> {
  bool isRememberMeChecked = false;
  bool passwordVisible = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode referralFocusNode = FocusNode();

  bool isEmailNotEmpty = false;
  bool isPasswordNotEmpty = false;

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    referralFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    SigInUpText.createAccount,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(SigInUpText.unlockTheWorld),
                  const SizedBox(height: 20),
                  const Text(
                    SignInText.email,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      fillColor: PickColor.textFeildColor,
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PickColor.blackTransparent),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PickColor.blackTransparent),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.email,
                        size: 20,
                        color: PickColor.greyColor,
                      ),
                      hintText: SignInText.email,
                      hintStyle: TextStyle(color: PickColor.greyColor),
                    ),
                    onSubmitted: (value) {
                      Focus.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    SignInText.password,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      fillColor: PickColor.textFeildColor,
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: PickColor.blackTransparent),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: PickColor.blackTransparent),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      prefixIcon: Icon(Icons.lock, size: 20, color: isPasswordNotEmpty ? PickColor.blackColor : PickColor.greyColor // Dynamic color
                          ),
                      hintText: SignInText.password,
                      hintStyle: const TextStyle(color: PickColor.greyColor),
                      suffixIcon: IconButton(
                        iconSize: 20,
                        icon: Icon(
                          passwordVisible ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onSubmitted: (value) {
                      referralFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    SigInUpText.refrelCode,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: referralController,
                    focusNode: referralFocusNode,
                    decoration: const InputDecoration(
                      fillColor: PickColor.textFeildColor,
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PickColor.blackTransparent),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PickColor.blackTransparent),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      hintText: "Referral Code",
                      hintStyle: TextStyle(color: PickColor.greyColor),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isRememberMeChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isRememberMeChecked = value ?? false;
                          });
                        },
                        side: const BorderSide(color: PickColor.brownColor, width: 2),
                        activeColor: PickColor.brownColor,
                        // Fill color when checked
                        checkColor: Colors.white, // Checkmark color
                      ),
                      const Text(
                        SigInUpText.iagree,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          SigInUpText.termsAndCondition,
                          style: TextStyle(
                            color: PickColor.brownColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(color: PickColor.borderColor),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(SigInUpText.alreadyHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SingInHomeScreen()),
                          );
                        },
                        child: const Text(
                          SignInText.signIn,
                          style: TextStyle(
                            color: PickColor.brownColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 180), // Adjust spacing
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 16.0,
            right: 16.0,
            // alignment: Alignment.bottomCenter,
            child: BottomButton(
              btnText: "Sign up",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompleteYourProfileScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
