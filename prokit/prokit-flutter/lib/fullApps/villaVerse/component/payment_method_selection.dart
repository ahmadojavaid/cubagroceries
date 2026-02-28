import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../utils/colors.dart';

class PaymentMethodSelection extends StatelessWidget {
  final VoidCallback voidCallBack;
  final Color? borderColor;
  final String imgPath;
  final Color? color;

  final String text;

  const PaymentMethodSelection({
    super.key,
    required this.text,
    required this.voidCallBack,
    required this.imgPath,
    this.color,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallBack,
      child: Card(
        shape: borderColor != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: borderColor!),
              )
            : null,
        color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
        child: ListTile(
          leading: Image.asset(imgPath, height: 30, width: 30, color: color),
          title: Text(text),
          trailing: Text('Connected', style: secondaryTextStyle(color: primaryBlueColor)),
        ),
      ).paddingSymmetric(horizontal: 16),
    );
  }
}