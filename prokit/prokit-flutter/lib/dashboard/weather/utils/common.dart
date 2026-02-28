import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget txtWidget(String label, double size, FontWeight fontWeight, Color color) {
  return Text(
    label,
    style: GoogleFonts.sourceCodePro(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
