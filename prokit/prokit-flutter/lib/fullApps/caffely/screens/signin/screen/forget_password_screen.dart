import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import 'otp_varification_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          LayoutBuilder(
            // Use LayoutBuilder to handle screen changes
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SignInText.resetPassword,
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 24),
                          Text(SignInText.enterOtp),
                          SizedBox(height: 20),
                          Text(SignInText.email, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              fillColor: PickColor.textFeildColor,
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                size: 20,
                                color: PickColor.greyColor,
                              ),
                              hintText: SignInText.hintText,
                              hintStyle: TextStyle(color: PickColor.greyColor),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 15.0,
            left: 16.0,
            right: 16.0,
            child: BottomButton(
              btnText: "Sign In",
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpVerificationScreen())),
              },
            ),
          )
        ],
      ),
    );
  }
}
