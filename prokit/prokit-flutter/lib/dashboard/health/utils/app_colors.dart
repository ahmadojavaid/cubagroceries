import 'package:flutter/material.dart';
import 'package:prokit_flutter/main.dart';

class HealthAppColors {
  Color get bgColor => appStore.isDarkModeOn? Colors.black: Colors.white;
  Color get white =>appStore.isDarkModeOn? Color.fromARGB(255, 35, 35, 35):Colors.white;
  Color get iconColor  => appStore.isDarkModeOn?Colors.white:  Color(0xff242425);
  Color get titleTXTColor => appStore.isDarkModeOn ?  Colors.white :Color(0xff2B2929);
  Color get subContainer =>appStore.isDarkModeOn? Color.fromARGB(255, 47, 47, 47): Color.fromARGB(255, 255, 255, 255);
  //Static
  Color blueColor = Color(0xff5546AF);
  Color black = Colors.black;
  Color purple = Colors.purple;
  Color deepPurple = Colors.deepPurple;
  Color grey300 = Colors.grey.shade300;
  Color grey = Colors.grey;
  Color boxShadow = Colors.black.withAlpha((0.08 * 255).toInt());
  Color subtitleTXTColor = Color(0xff969393);
  Color cardIconColor = Color(0xff8A8A8A);
  Color barChat1 = Color(0xffF0F2F4);
  Color barChat2 = Color(0xff619373);
  Color completedStep = Color(0xFF5F60B9);
  Color green700 = Colors.green.shade700;
  Color black12 = Colors.black12;
  Color constWhite = Colors.white;
  static const Color constGrey = Colors.grey;
  static const Color constCompletedStep = Color(0xFF5F60B9);
}
