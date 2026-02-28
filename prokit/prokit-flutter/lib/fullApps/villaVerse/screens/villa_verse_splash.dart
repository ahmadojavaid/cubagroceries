// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/walkthrought/welcome_screen.dart';

import '../utils/colors.dart';
import '../../../../main.dart';
import '../utils/image.dart';

class VillaVerseSplashScreen extends StatefulWidget {
  static String tag = '/villa_verse';

  const VillaVerseSplashScreen({super.key});

  @override
  State<VillaVerseSplashScreen> createState() => _VillaVerseSplashScreenState();
}

class _VillaVerseSplashScreenState extends State<VillaVerseSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(2.seconds);
    WelcomeScreen().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: Stack(
        children: [
          Center(child: Image.asset(villaVerse, height: 200, width: 200)),
          Positioned(
            bottom: 90,
            left: context.width() * .43,
            right: context.width() * .43,
            child: SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryBlueColor,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
