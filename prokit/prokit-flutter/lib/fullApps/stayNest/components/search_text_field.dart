import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../utils/colors.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isDarkMode;
  final VoidCallback? onTap;

  SearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isDarkMode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 50, // Using nb_utils height
        child: TextField(
          style: TextStyle(
            color: appStore.isDarkModeOn ? const Color.fromARGB(255, 62, 62, 62) : const Color.fromARGB(255, 234, 232, 232),
          ),
          controller: controller,
          onTap: onTap,
          onChanged: (value) => controller.text = value,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: stayNestPrimaryColor),
            hintText: hintText,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: stayNestPrimaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : const Color.fromARGB(255, 214, 213, 213),
              ),
            ),
          ),
        ),
      ),
    ).paddingSymmetric(horizontal: 16);
  }
}
