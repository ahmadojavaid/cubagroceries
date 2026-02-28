import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? toggleObscure;
  final bool isPassword;
  final bool isDate;
  final VoidCallback? onTap;
  final TextInputType? keyboardType; // ✅ Added keyboardType

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.toggleObscure,
    this.isPassword = false,
    this.isDate = false,
    this.onTap,
    this.keyboardType, // ✅ Added in constructor
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      textFieldType: _getTextFieldType(),
      readOnly: isDate,
      onTap: isDate ? onTap : null,
      keyboardType: keyboardType,
      decoration: inputDecoration(
        label,
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: toggleObscure,
              )
            : isDate
                ? const Icon(Icons.calendar_today, color: Colors.grey)
                : null,
      ),
      isPassword: isPassword,
      obscureText: obscureText,
    );
  }

  TextFieldType _getTextFieldType() {
    if (isPassword) return TextFieldType.PASSWORD;
    if (isDate) return TextFieldType.OTHER;

    // Guess best default based on keyboardType if provided
    switch (keyboardType) {
      case TextInputType.number:
        return TextFieldType.NUMBER;
      case TextInputType.phone:
        return TextFieldType.PHONE;
      case TextInputType.emailAddress:
        return TextFieldType.EMAIL;
      default:
        return TextFieldType.NAME;
    }
  }

  InputDecoration inputDecoration(
    String label, {
    String? hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      labelStyle: const TextStyle(color: stayNestPrimaryColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: stayNestPrimaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: appStore.isDarkModeOn ? const Color.fromARGB(255, 87, 82, 82) : stayNestPrimaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: stayNestPrimaryColor, width: 2),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
