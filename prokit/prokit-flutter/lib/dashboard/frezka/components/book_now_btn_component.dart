import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';

class BookNowBtn extends StatelessWidget {
  const BookNowBtn({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      height: 48,
      width: 380,
      decoration: BoxDecoration(
        color: frezlaAppColor.btnColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: txtWidget("Book now", 14, FontWeight.w500, frezlaAppColor.constWhite),
      ),
    );
  }
}
