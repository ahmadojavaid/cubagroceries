import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

InputDecoration inputDecoration(
  BuildContext context, {
  Widget? prefixIcon,
  Widget? prefix,
  String? label,
  TextStyle? labelStyle,
  String? hint,
  Color? fillColor,
  String? counterText,
  double? borderRadius,
  Widget? suffixIcon,
  Widget? suffix,
  String? prefixText,
}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
      hintText: hint,
      hintStyle: secondaryTextStyle(size: 18),
      labelText: label,
      labelStyle: secondaryTextStyle(),
      alignLabelWithHint: true,
      counterText: counterText,
      prefixIcon: prefixIcon,
      prefix: prefix,
      suffix: suffix,
      prefixText: prefixText,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: const BorderSide(width: 0.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: const BorderSide(color: Colors.red, width: 0.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: const BorderSide(color: Colors.red, width: 1.0),
      ),
      errorMaxLines: 2,
      border: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      ),
      errorStyle: primaryTextStyle(color: Colors.red, size: 12),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius(borderRadius ?? defaultRadius),
        borderSide: const BorderSide(color: movieaPrimaryColor, width: 0.0),
      ),
      filled: true,
      // fillColor: fillColor ?? context.cardColor,
      fillColor: Colors.white);
}
