import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../home/screen/home_page_screen.dart';
import '../../signup/screen/create_account_screen.dart';
import 'forget_password_screen.dart';

class SingInWithPasswordScreen extends StatefulWidget {
  const SingInWithPasswordScreen({super.key});

  @override
  _SinginWithPasswordState createState() {
    return _SinginWithPasswordState();
  }
}

class _SinginWithPasswordState extends State<SingInWithPasswordScreen> {
  bool isRememberMeChecked = false;
  bool passwordVisible = true; // Initially set the password as hidden

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome back 👋",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text("Please enter your email & password to sign in"),
                        const SizedBox(height: 20),
                        const Text(
                          "Email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: emailController,
                          focusNode: emailFocusNode,
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
                            // Switch to password field when the user submits the email
                            FocusScope.of(context).requestFocus(passwordFocusNode);
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
                          focusNode: passwordFocusNode,
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
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 20,
                              color: Colors.grey,
                            ),
                            hintText: SignInText.password,
                            hintStyle: const TextStyle(color: PickColor.greyColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisible ? Icons.visibility_off : Icons.visibility, size: 20, // Toggles visibility icon
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible; // Toggle hidden text
                                });
                              },
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done, // Done action for password field
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                  SignInText.reemeberMe,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            // const SizedBox(width: ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
                                );
                              },
                              child: const Text(
                                SignInText.forgetPassword,
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
                            const Text(SignInText.dontHaveAccount),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                                );
                              },
                              child: const Text(
                                SignInText.signUp,
                                style: TextStyle(
                                  color: PickColor.brownColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(), // Automatically pushes the button to the bottom
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          left: 16.0,
          right: 16.0,
          child: BottomButton(
              btnText: "Sign in",
              onTap: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 4), () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePageScreen()),
                          );
                        });
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(20.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(
                                Images.img_lottie4,
                                height: 200,
                                reverse: true,
                                repeat: true,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                SignInText.signSuccessful,
                                style: TextStyle(fontSize: 30),
                              ),
                              const SizedBox(height: 13),
                              const Text(SignInText.pleaseWait),
                              const Text(SignInText.directHome),
                            ],
                          ),
                          actions: const [],
                        );
                      },
                    )
                  }),
        )
      ]),
    );
  }
}
