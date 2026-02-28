import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/signin/screen/singin_with_password_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../signup/screen/create_account_screen.dart';

class SingInHomeScreen extends StatefulWidget {
  const SingInHomeScreen({super.key});

  @override
  State<SingInHomeScreen> createState() => _SingInHomeScreenState();
}

final List<Map<String, dynamic>> signupList = [
  {"image": Images.img_googleLogo, "text": "Continue with Google"},
  {"image": Images.img_appleLogo, "text": "Continue with Apple"},
  {"image": Images.img_facebookLogo, "text": "Continue with Facebook"},
  {"image": Images.img_twitter, "text": "Continue with Twitter"}
];

class _SingInHomeScreenState extends State<SingInHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  Lottie.asset(
                    Images.img_lottie3,
                    height: 170,
                    reverse: true,
                    repeat: true,
                  ),
                  const SizedBox(height: 15),
                  Text(SignInText.caffely, style: GoogleFonts.pacifico(fontSize: 45)),
                  const SizedBox(height: 25),
                  const Text(SignInText.letsDive, style: TextStyle(fontSize: 15)),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: signupList.length,
                    itemBuilder: (context, index) {
                      final signupData = signupList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: PickColor.borderColor),
                            padding: const EdgeInsets.only(left: 7),
                            elevation: 0, // Removes the shadow
                            backgroundColor: PickColor.whiteColor.withOpacity(0.60),
                          ),
                          child: Row(
                            children: [
                              Image.network(signupData["image"], height: 25),
                              const SizedBox(width: 70),
                              Text(signupData["text"], style: const TextStyle(color: PickColor.blackColor)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BottomButton(
                    btnText: "Sign in with password",
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SingInWithPasswordScreen()),
                      ),
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
