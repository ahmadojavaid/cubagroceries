import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import '../utils/images.dart';
import 'walk_through/view/walk_through_screen.dart';

class MovieaSplashScreen extends StatefulWidget {
  static String tag = '/moviea';

  const MovieaSplashScreen({super.key});

  @override
  State<MovieaSplashScreen> createState() => _MovieaSplashScreenState();
}

class _MovieaSplashScreenState extends State<MovieaSplashScreen> {
  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: context.scaffoldBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: context.scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ));
    });

    Timer(const Duration(seconds: 3), () {
      finish(context);
      const WalkThroughScreen().launch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Image.network(logoGif, height: 120, width: 120, fit: BoxFit.cover),
            ),
            Text(
              'Moviea',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: movieaPrimaryColor,
                fontFamily: GoogleFonts.lexendDeca().fontFamily,
              ),
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }
}
