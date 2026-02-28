import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';

Widget titleRowWidget(String title, String? title2) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            height: 1.5,
            color: handymanAppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Text(
          title2!,
          style: GoogleFonts.inter(
            height: 1.5,
            color: handymanAppColor.blueCustom,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
