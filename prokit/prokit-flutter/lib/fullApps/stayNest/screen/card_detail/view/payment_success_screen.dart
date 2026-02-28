import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/rounded_text_button.dart';
import '../../../utils/colors.dart';
import '../../page_slider.dart';

void showPaymentSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: appStore.isDarkModeOn ? black : Color(0xFFE8EDFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: appStore.isDarkModeOn ? const Color.fromARGB(255, 65, 65, 65) : Color(0xFFE8EDFF),
          ),
        ),
        insetPadding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appStore.isDarkModeOn ? Color(0xFFE8EDFF) : stayNestPrimaryColor.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: stayNestPrimaryColor,
                  size: 48,
                ),
              ),
              16.height,
              Text(
                'Payment Received\nSuccessfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              12.height,
              Text(
                'Congratulations 🎉\nYour booking has been confirmed',
                textAlign: TextAlign.center,
                style: secondaryTextStyle(size: 14),
              ),
              24.height,
              RoundedTextButton(
                backgroundColor: stayNestPrimaryColor,
                textColor: whitecolor,
                onPressed: () {
                  Navigator.of(context).pop();
                  PageSlider().launch(context);
                },
                text: "Back to Home",
              ),
            ],
          ),
        ),
      );
    },
  );
}
