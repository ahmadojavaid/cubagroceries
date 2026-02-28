// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../fullApps/stayNest/screen/walkthrough_screen.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class StayNestSplashScreen extends StatefulWidget {
  static String tag = '/staynest';

  const StayNestSplashScreen({super.key});

  @override
  State<StayNestSplashScreen> createState() => _StayNestSplashScreenState();
}

class _StayNestSplashScreenState extends State<StayNestSplashScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.light);
    init();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> init() async {
    await Future.delayed(2.seconds);
    if (mounted) {
      WalkthroughScreen().launch(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WalkthroughScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stayNestPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(appLogo, height: 300, width: 300),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    "Your Comfort, Your Stay - Hotel Booking Made Easy",
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle(
                      fontStyle: FontStyle.italic,
                      color: whiteColor,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            60.height,
          ],
        ),
      ),
    );
  }
}
