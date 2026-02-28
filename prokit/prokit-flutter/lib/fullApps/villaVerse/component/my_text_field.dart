import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Color hintTextColor;
  final Color fillColor;
  final TextInputType? keyboardType;
  final IconData? sufixIcondata;
  final Widget? prefixIcondata;
  final bool hideText;
  final VoidCallback? voidCallBack;
  final bool readOnly;

  MyTextField(
      {super.key,
      this.controller,
      required this.hintTextColor,
      required this.prefixIcondata,
      required this.fillColor,
      required this.hintText,
      required this.keyboardType,
      required this.sufixIcondata,
      this.hideText = false,
      this.readOnly = false,
      this.voidCallBack}) {
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: voidCallBack,
      readOnly: readOnly,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      obscureText: hideText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcondata,
        suffixIcon: Icon(sufixIcondata),
        suffixIconColor: hintTextColor,
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        hintStyle: TextStyle(color: hintTextColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
