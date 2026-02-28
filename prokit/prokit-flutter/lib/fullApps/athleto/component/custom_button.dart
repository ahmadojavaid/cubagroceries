import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textcolor;

  const CustomButton({super.key, required this.text, this.textcolor, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      textStyle: boldTextStyle(size: 16, color: textcolor ?? white),
      textColor: textcolor ?? Colors.grey[300],
      color: color ?? buttonColor,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.grey),
      ),
      onTap: onPressed,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      width: 180,
    );
  }
}
