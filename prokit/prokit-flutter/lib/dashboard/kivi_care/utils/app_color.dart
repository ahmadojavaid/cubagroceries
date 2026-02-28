import 'package:flutter/material.dart';
import 'package:prokit_flutter/main.dart';

class KiviCareAppColor {
  Color get containerColor =>
      appStore.isDarkModeOn ? Colors.black : Color(0xffF5F6FA);
  Color get subContainerColor => appStore.isDarkModeOn
      ? Color.fromARGB(255, 47, 47, 47)
      : Color(0xffF5F6FA);
  Color get whiteColor => appStore.isDarkModeOn
      ? Color.fromARGB(255, 35, 35, 35)
      : Color(0xffffffff);
  Color get headingColor =>
      appStore.isDarkModeOn ? Colors.white : Color(0xff3F414D);
  Color get nameText =>
      appStore.isDarkModeOn ? Colors.white : Color(0xff3F414D);
  Color get navigationBGColor => appStore.isDarkModeOn
      ? Color.fromARGB(255, 35, 35, 35)
      : Color(0xff1A1817);

//constant
  Color bgColor = Color(0xff5670CC);
  Color redColor = Color(0xffF67E7D);
  Color constWhite = Colors.white;
  Color redText = Color(0xffF54438);
  Color greenText = Color(0xff219653);
  Color dividerColor = Color(0xffD8D9D9);
  Color fadeText = Color(0xff828A90);
}
