import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../utils/colors.dart';

class CardReviewSummary extends StatelessWidget {
  final String lable1;
  final String text1;
  final String lable2;
  final String text2;
  final String lable3;
  final String text3;
  final Color? dividerColor;
  final String? copy;

  const CardReviewSummary({
    super.key,
    required this.text1,
    required this.lable1,
    required this.lable2,
    required this.lable3,
    required this.text2,
    required this.text3,
    this.dividerColor,
    this.copy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
      elevation: 00,
      child: Column(
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lable1,
                style: secondaryTextStyle(),
              ),
              Text(
                text1,
                style: primaryTextStyle(),
              )
            ],
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lable2,
                style: secondaryTextStyle(),
              ),
              Text(
                text2,
                style: primaryTextStyle(),
              )
            ],
          ),
          dividerColor != null
              ? Column(
                  children: [
                    10.height,
                    Divider(color: dividerColor),
                    10.height,
                  ],
                )
              : 16.height,
          Row(
            children: [
              Text(
                lable3,
                style: secondaryTextStyle(color: hintTextColor),
              ),
              Expanded(child: SizedBox()),
              Text(
                text3,
                style: primaryTextStyle(),
              ),
              copy != null
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: primaryBlueColor),
                        ),
                        color: appStore.isDarkModeOn
                            ? inputFillColorDart
                            : inputFillColorlight,
                        child: Text(
                          copy!,
                          style: TextStyle(
                            color: primaryBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ).paddingSymmetric(horizontal: 8, vertical: 3),
                      ),
                    )
                  : SizedBox(width: 0)
            ],
          ),
          16.height
        ],
      ).paddingSymmetric(horizontal: 15),
    ).paddingSymmetric(horizontal: 16);
  }
}
