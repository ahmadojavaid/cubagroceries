import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import 'new_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  int resendSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      resendSeconds = 20;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          resendSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: appStore.isDarkModeOn ? const Color.fromARGB(255, 75, 75, 75) : stayNestPrimaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter OTP Code",
              style: appStore.isDarkModeOn ? TextStyle(color: whiteColor, fontSize: 24) : TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              "OTP code has been sent to (406) 555-0120",
              style: TextStyle(color: Colors.grey),
            ),
            32.height,
            Center(
              child: Pinput(
                autofocus: true,
                controller: _pinController,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                onCompleted: (value) {},
              ),
            ),
            16.height,
            Center(
              child: TextButton(
                onPressed: resendSeconds == 0 ? _startResendTimer : null,
                child: Text.rich(
                  TextSpan(
                    text: 'Resend code ',
                    style: resendSeconds == 0 ? boldTextStyle(color: stayNestPrimaryColor) : TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: resendSeconds == 0 ? null : '00:${resendSeconds.toString().padLeft(2, '0')}s',
                        style: const TextStyle(
                          color: stayNestPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(child: Image.asset(otp, height: 250)),
            32.height,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  hideKeyboard(context);
                  NewPasswordScreen().launch(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: stayNestPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
