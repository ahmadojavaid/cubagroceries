import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? imageIcon;
  final bool isPassword;
  final TextFieldType? textFieldType;

  const CustomTextField({super.key, required this.hintText, this.isPassword = false, this.imageIcon, this.controller, this.textFieldType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? isObscured : false,suffixIconColor: white,
      textFieldType: widget.textFieldType ?? TextFieldType.OTHER,
      textStyle: primaryTextStyle(color: white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: primaryTextStyle(color: white),

        filled: true,
        // fillColor: Color(0xFFFFFFFF),
        fillColor: buttonColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
suffixIconColor: white,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: white,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            //TODO:
            : ImageIcon(
                AssetImage(
                  widget.imageIcon ?? "images/athleto/icons/person2.png",
                ),
                size: 14,
                color: white,
              ).paddingAll(12.5),
      ),
    );
  }
}
