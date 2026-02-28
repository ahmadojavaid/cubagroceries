import 'package:flutter/material.dart';
import 'package:prokit_flutter/main.dart';

class KiviLabAppColors {
  Color get black => appStore.isDarkModeOn ? Colors.white : Colors.black;
  Color get bgColor => appStore.isDarkModeOn ? Colors.black : Colors.white;
  Color get white =>
      appStore.isDarkModeOn ? Color.fromARGB(255, 35, 35, 35) : Colors.white;
  Color get titleTXT =>
      appStore.isDarkModeOn ? Colors.white : Color(0xff3F414D);
  Color get appontCard => appStore.isDarkModeOn
      ? Color.fromARGB(255, 47, 47, 47)
      : Color(0xffF5F6FA);
  Color get grey => appStore.isDarkModeOn ? Colors.transparent : Colors.grey;
  Color get btn => appStore.isDarkModeOn ? Colors.white : Color(0xff6E8192);

//Const
  Color topContainer = Color(0xff5670CC);
  Color topContainerBTN = Color(0xff6E84D3);
  Color constBlack = Colors.black;
  Color constWhite = Colors.white;
  Color blue700 = Colors.blue.shade700;
  Color iconBtn = Color(0xff6E8192);
  Color greyTXT = Color(0xff828A90);
  Color secondaryColor = Color(0xffF67E7D);
  Color appontContainer = Color(0xffF5F6FA);
  Color red = Color(0xffF54438);
  Color green = Color(0xff219653);
}
