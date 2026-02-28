// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../page_slider.dart';

void showPasswordUpdatedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: appStore.isDarkModeOn ? blackColor : whiteColor,
        shape: RoundedRectangleBorder(borderRadius: radius(20)),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              24.height,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8EDFF),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: stayNestPrimaryColor,
                  size: 48,
                ),
              ),
              20.height,
              Text(
                'Password Update\nSuccessfully',
                textAlign: TextAlign.center,
                style: appStore.isDarkModeOn ? TextStyle(color: whiteColor, fontSize: 20) : boldTextStyle(size: 20),
              ),
              12.height,
              Text(
                'Your password has been\nupdated successfully',
                textAlign: TextAlign.center,
                style: secondaryTextStyle(size: 14),
              ),
              24.height,
              AppButton(
                text: 'Back to Home',
                textStyle: boldTextStyle(color: white),
                width: context.width(),
                elevation: 0,
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(12)),
                color: stayNestPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                onTap: () {
                  context.pop();
                  PageSlider().launch(context);
                },
              ),
            ],
          ).paddingAll(24),
        ),
      );
    },
  );
}
