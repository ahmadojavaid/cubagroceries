import 'package:flutter/material.dart';
import 'package:prokit_flutter/main.dart';


class FrezkaAppColor {
 
  Color get bgColor => appStore.isDarkModeOn ? Colors.black : Colors.white;
  Color get white => appStore.isDarkModeOn ? Color.fromARGB(255, 24, 24, 24) : Colors.white;
  Color get black => appStore.isDarkModeOn ? Colors.white : Colors.black;
  Color get headLineColor => appStore.isDarkModeOn ?Colors.white :Color(0xff050505);
  Color get btnColor => appStore.isDarkModeOn ?Color.fromARGB(255, 42, 59, 152):Color(0xff19235A);
  Color get highlightedCard =>appStore.isDarkModeOn?Color.fromARGB(255, 24, 24, 24) :Color(0xffF2EBFF);
  Color get timePickerContainer => appStore.isDarkModeOn?Color.fromARGB(255, 47, 47, 47):Color(0xffFAF8FF);
  //static
  Color topContainerColor = Color(0xffA82D86);
  Color grey = Colors.grey;
  Color constHeadline = Color(0xff050505);
  Color grey400 = Colors.grey.shade400;
  Color deepPurple = Colors.deepPurple;
  Color transparent = Colors.transparent;
  Color blackShadow = Colors.black.withAlpha((0.1 * 255).toInt());
  Color dividerBarColor = Color(0xffB9579E);
  Color topContainerIcon = Color(0xffA6A8A8);
  Color constWhite = Colors.white;
  Color constBlack = Colors.black;
  Color dateTxtColor = Color(0xff6C757D);
  Color priceTxtColor = Color(0xffA82D86);
  Color rateStarColor = Color(0xffF6BD60);
  Color rateContainer = Color(0xffFAF8FF);
  Color openBTN = Color(0xffEBFFF5);
  Color openBTNTXT = Color(0xff09954D);
  Color membershipContainer = Color(0xffFFE5BE);
  Color membershipCircleBG = Color(0xff19235A);
  Color expertContainer = Color(0xFFFFF4E7);
  Color selectedTime = Color(0xFFDFD3FF);
}
