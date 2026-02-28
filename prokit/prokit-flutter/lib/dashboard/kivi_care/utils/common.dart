import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';


Widget textWidget(String txt, double size, FontWeight fontWeight) {
  return Text(
    txt,
    style: GoogleFonts.interTight(
      color: kiviCareAppColor.whiteColor,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}
Widget useTXTWidget(String txt, double size, FontWeight fontWeight) {
  return Text(
    txt,
    style: GoogleFonts.interTight(
      color: kiviCareAppColor.constWhite,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

Widget titleRowWidget(String txt1, String txt2) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt1,
          style: GoogleFonts.interTight(
            color: kiviCareAppColor.headingColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          txt2,
          style: GoogleFonts.interTight(
            color: kiviCareAppColor.redColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget txtWidget(String label, double size, FontWeight fontWeight, Color color) {
  return Text(
    label,
    style: GoogleFonts.interTight(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}
