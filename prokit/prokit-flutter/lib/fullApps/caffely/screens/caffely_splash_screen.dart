import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../utils/images.dart';
import 'starter_screen.dart/screen/on_boarding_screen.dart';

class CaffelySplashScreen extends StatefulWidget {
  static String tag = '/caffely';

  const CaffelySplashScreen({super.key});

  @override
  State<CaffelySplashScreen> createState() => _CaffelySplashScreenState();
}

class _CaffelySplashScreenState extends State<CaffelySplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  Images.ic_appIcon,
                  height: 180,
                  width: 180,
                ),
                const SizedBox(height: 20),
                Text("Caffely", style: GoogleFonts.pacifico(fontSize: 40)),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Lottie.asset(
              Images.img_lottieSplaceLoader,
              height: 200,
              reverse: true,
              repeat: true,
            ),
          )
        ]),
      ),
    );
  }
}
