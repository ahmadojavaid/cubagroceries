import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';


Widget txtWidget(String label, double size, FontWeight fontWeight, Color color) {
  return Text(
    label,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.lexendDeca(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget iconWidget(IconData icons, double size, Color color) {
  return Icon(icons, size: size, color: color);
}

Widget titleRowWidget(String txt1, String txt2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      txtWidget(txt1, 18, FontWeight.w500, frezlaAppColor.headLineColor),
      txtWidget(txt2, 12, FontWeight.w500, frezlaAppColor.priceTxtColor),
    ],
  );
}

BoxDecoration decoratedContainerWidget() {
  return BoxDecoration(
    color: frezlaAppColor.white,
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: frezlaAppColor.black.withAlpha((0.05 * 255).toInt()),
        offset: const Offset(0, 4),
        blurRadius: 10,
      ),
    ],
  );
}
