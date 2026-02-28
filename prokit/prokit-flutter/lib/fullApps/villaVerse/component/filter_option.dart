import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class FilterOption extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const FilterOption({super.key, required this.text, required this.textColor, required this.backgroundColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: primaryBlueColor),
      ),
      color: backgroundColor,
      elevation: 0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: textColor, size: 20),
          if (icon != null) 5.width,
          Text(text, style: TextStyle(color: textColor)),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 5),
    );
  }
}
