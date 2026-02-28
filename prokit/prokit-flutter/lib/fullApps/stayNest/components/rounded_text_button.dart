import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class RoundedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const RoundedTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = stayNestPrimaryColor,
    this.textColor = whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      textColor: textColor,
      color: backgroundColor,
      elevation: 0,
      onTap: onPressed,
      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      width: context.width(),
      height: 50,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: whiteColor,
      ),
    );
  }
}
