import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'createnew_password_screen.dart'; // import the next screen

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  _OtpVerificationState createState() {
    return _OtpVerificationState();
  }
}

class _OtpVerificationState extends State<OtpVerificationScreen> {
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;

  // Add controllers for each OTP field
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  // Focus nodes for each OTP field to track the current focus
  final FocusNode focusNodeOtp1 = FocusNode();
  final FocusNode focusNodeOtp2 = FocusNode();
  final FocusNode focusNodeOtp3 = FocusNode();
  final FocusNode focusNodeOtp4 = FocusNode();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
        timer.cancel();
      }
    });
  }

  void resendCode() {
    if (enableResend) {
      setState(() {
        secondsRemaining = 52;
        enableResend = false;
      });
      startTimer();
    }
  }

  @override
  void dispose() {
    timer.cancel();

    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();

    focusNodeOtp1.dispose();
    focusNodeOtp2.dispose();
    focusNodeOtp3.dispose();
    focusNodeOtp4.dispose();

    super.dispose();
  }

  // Function to check if OTP is complete and navigate to the next screen
  void checkOtpAndNavigate() {
    if (otp1.text.isNotEmpty && otp2.text.isNotEmpty && otp3.text.isNotEmpty && otp4.text.isNotEmpty) {
      // Here you can verify the OTP if necessary, then navigate
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateNewPasswordScreen()),
      );
    } else {
      // Show a message or error if OTP is not fully entered
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(SignInText.pleaseEnterOtp)),
      );
    }
  }

  // Function to return border based on focus state
  InputBorder getOtpFieldBorder(FocusNode focusNode) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: focusNode.hasFocus ? PickColor.brownColor : PickColor.blackTransparent,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              SignInText.otpVarification,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(SignInText.sentEmail),
            const SizedBox(height: 15),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // OTP Field 1
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      controller: otp1,
                      focusNode: focusNodeOtp1,
                      cursorColor: PickColor.brownColor,
                      autofocus: true,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: PickColor.textFeildColor,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: getOtpFieldBorder(focusNodeOtp1),
                        focusedBorder: getOtpFieldBorder(focusNodeOtp1),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  // OTP Field 2
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      controller: otp2,
                      focusNode: focusNodeOtp2,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: PickColor.textFeildColor,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: getOtpFieldBorder(focusNodeOtp2),
                        focusedBorder: getOtpFieldBorder(focusNodeOtp2),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  // OTP Field 3
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      controller: otp3,
                      focusNode: focusNodeOtp3,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: PickColor.textFeildColor,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: getOtpFieldBorder(focusNodeOtp3),
                        focusedBorder: getOtpFieldBorder(focusNodeOtp3),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  // OTP Field 4
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      controller: otp4,
                      focusNode: focusNodeOtp4,
                      onChanged: (value) {
                        if (value.length == 1) {
                          checkOtpAndNavigate(); // Check if OTP is complete and navigate
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: PickColor.textFeildColor,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: getOtpFieldBorder(focusNodeOtp4),
                        focusedBorder: getOtpFieldBorder(focusNodeOtp4),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(SignInText.didntReciveMail, style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 10),
            Center(
              child: enableResend
                  ? TextButton(
                      onPressed: resendCode,
                      child: const Text(
                        SignInText.resendCode,
                        style: TextStyle(color: PickColor.brownColor),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          SignInText.youCanResend,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "$secondsRemaining ",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 105, 48, 27),
                          ),
                        ),
                        const Text(SignInText.s),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
