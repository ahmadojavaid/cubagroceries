import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'otp_dialog_component.dart';

class EmailVerifyDialogComponent extends StatefulWidget {
  const EmailVerifyDialogComponent({super.key});

  @override
  State<EmailVerifyDialogComponent> createState() => _EmailVerifyDialogComponentState();
}

class _EmailVerifyDialogComponentState extends State<EmailVerifyDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: context.height() * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Verify Your Email Address", style: TextStyle(fontSize: 16)),
                10.height,
                const Text(
                  "(405) 555-0128",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                10.height,
                const Text(
                  "We will send the authentication code to this mobile number you entered. Do you want continue?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    elevation: 0,
                    color: Colors.white,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(color: Colors.red),
                    ),
                    onTap: () async {
                      finish(context);
                    },
                    child: Text("Cancel", style: boldTextStyle(color: Colors.red)),
                  ).expand(),
                  16.width,
                  AppButton(
                    elevation: 0,
                    color: Colors.red,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    onTap: () async {
                      finish(context);

                      showDialog(
                        context: context,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: const OTPDialogComponent(),
                        ),
                      );
                    },
                    child: Text("Next", style: boldTextStyle(color: Colors.white)),
                  ).expand(),
                ],
              ),
            )
          ],
        ).paddingAll(16),
      ),
    );
  }
}
