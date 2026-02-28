import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';


Widget titleRowWidget(String label) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.roboto(
          color: streamITAppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Icon(Icons.arrow_forward_ios_outlined, size: 16, color: streamITAppColors.white),
    ],
  ),
);
