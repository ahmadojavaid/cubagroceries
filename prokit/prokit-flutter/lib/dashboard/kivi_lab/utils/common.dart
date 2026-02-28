import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';


Widget txtWidget(String text, double size, FontWeight fontWeight, Color color) {
  return Text(
    text,
    style: GoogleFonts.interTight(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Widget titleRowWidget(String txt1, String txt2) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        txtWidget(txt1, 16, FontWeight.w600, kiviLabAppColors.titleTXT),
        txtWidget(txt2, 12, FontWeight.w600, kiviLabAppColors.secondaryColor),
      ],
    ),
  );
}

Widget cardRowWidget(String text, Widget tail) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [txtWidget(text, 12, FontWeight.w400, kiviLabAppColors.greyTXT), tail],
    ),
  );
}



  Widget iconRowWidget(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: kiviLabAppColors.titleTXT),
        SizedBox(width: 14),
        txtWidget(text, 12, FontWeight.w400, kiviLabAppColors.greyTXT),
      ],
    );
  }
