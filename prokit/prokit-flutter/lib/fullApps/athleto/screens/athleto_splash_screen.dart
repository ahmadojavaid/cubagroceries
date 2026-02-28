import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../athleto/utils/colors.dart';
import '../utils/image.dart';
import 'onboarding_screen.dart';

class AthletoSplashScreen extends StatefulWidget {
  static String tag = '/athleto';

  const AthletoSplashScreen({super.key});

  @override
  _AthletoSplashScreenState createState() => _AthletoSplashScreenState();
}

class _AthletoSplashScreenState extends State<AthletoSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(2.seconds);
    OnboardingScreen().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            splash_1,
            fit: BoxFit.fitHeight,
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              16.height,
              Text(
                'Welcome to',
                style: boldTextStyle(
                  color: Colors.white,
                  size: 32,
                ).copyWith(fontStyle: FontStyle.italic),
              ),
              16.height,
              Image.asset(logo, width: 200, height: 200),
            ],
          ).center(),
        ],
      ),
    );
  }
}
