import 'package:flutter/material.dart';
import 'package:prokit_flutter/main.dart';

class HandymanAppColor {
  Color get bgColor => appStore.isDarkModeOn ? Colors.black : Colors.white;
  Color get whiteColor =>
      appStore.isDarkModeOn ? Color.fromARGB(255, 35, 35, 35) : Colors.white;
  Color get blackColor => appStore.isDarkModeOn ? Colors.white : Colors.black;
  Color get upcomingBlackTxt =>
      appStore.isDarkModeOn ? Colors.white : Color(0xFF0F172A);
  Color get cancelBtnColor => appStore.isDarkModeOn
      ? Color.fromARGB(255, 47, 47, 47)
      : Color(0xFFF9FAFB);

  //Constant
  Color white60 = Colors.white60;
  Color black6 = Colors.black.withAlpha((0.6 * 255).toInt());
  Color black2 = Colors.black.withAlpha((0.2 * 255).toInt());
  Color black12 = Colors.black12;
  Color transparent = Colors.transparent;
  Color blueCustom = Color(0xff5F60B9);
  Color greenColor = Colors.green;
  Color constBlack = Colors.black;
  Color constWhite = Colors.white;
  Color greyColor = Colors.grey;
  Color blueColor = Colors.blue;
  Color redColor = Colors.red;
  Color btnColor = Color(0xff1C1F34);
  Color requestContainerColor = Color(0xffE4BB97);
  Color upcomingIcon = Color(0xff6C757D);
}
