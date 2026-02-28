import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_input_editor/otp_input_editor.dart';

import 'account_created_dialog_component.dart';

class OTPDialogComponent extends StatefulWidget {
  const OTPDialogComponent({super.key});

  @override
  State<OTPDialogComponent> createState() => _OTPDialogComponentState();
}

class _OTPDialogComponentState extends State<OTPDialogComponent> {
  int countdown = 60;
  bool showResendButton = false;

  @override
  void initState() {
    super.initState();
    countdownTick();
  }

  Future<void> countdownTick() async {
    while (countdown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          countdown--;
        });
      }
    }
    if (mounted) {
      setState(() {
        showResendButton = true;
      });
    }
  }

  void restartCountdown() {
    setState(() {
      countdown = 60;
      showResendButton = false;
    });
    countdownTick();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: context.height() * 0.4,
        width: context.width(),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Enter OTP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Text(
                  "A verification codes has been sent to (405) 555-0128",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ).paddingOnly(top: 5),
                10.height,
                OtpInputEditor(
                  otpLength: 4,
                  textInputStyle: const TextStyle(color: Colors.black, backgroundColor: Colors.white),
                  obscureText: false,
                  boxDecoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ).paddingOnly(top: 5),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: context.width(),
                    child: AppButton(
                      elevation: 0,
                      color: Colors.red,
                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      onTap: () async {
                        finish(context);
                        showDialog(
                          context: context,
                          builder: (context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: const AccountCreatedDialogComponent(),
                          ),
                        );
                      },
                      child: Text("Verify", style: boldTextStyle(color: Colors.white)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the code?", style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: showResendButton
                            ? () {
                                restartCountdown();
                              }
                            : null,
                        child: Text(
                          showResendButton ? 'Resend' : 'Resend($countdown${countdown != 0 ? "s" : ""})',
                          style: secondaryTextStyle(color: showResendButton ? Colors.grey : Colors.red, size: 16),
                        ),
                      ),
                    ],
                  ).fit(),
                ],
              ),
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
