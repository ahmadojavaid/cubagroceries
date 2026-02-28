import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';


class CustomAppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  final Color? hintTextColor;
  final Color? textColor;
  final Color? fillColor;
  final VoidCallback? voidCallback;

  const CustomAppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.suffixIcon,
    this.hintTextColor,
    this.textColor,
    this.fillColor,
    this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedFillColor = context.cardColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: boldTextStyle(size: 16)),
        8.height,
        AppTextField(
          controller: controller,
          textFieldType: _getFieldType(),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintTextColor),
            filled: true,
            fillColor: resolvedFillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: voidCallback != null ? GestureDetector(onTap: voidCallback, child: suffixIcon) : suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlueColor),
                  borderRadius: BorderRadius.circular(16),
                ),
          ),
        ),
        16.height,
      ],
    );
  }

  TextFieldType _getFieldType() {
    if (keyboardType == TextInputType.number) return TextFieldType.NUMBER;
    if (keyboardType == TextInputType.datetime) return TextFieldType.OTHER;
    return TextFieldType.NAME;
  }
}
