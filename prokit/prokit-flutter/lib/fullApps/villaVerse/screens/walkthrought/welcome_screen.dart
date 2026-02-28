// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/walkthrought/walkthrought.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/walkthrought/walkthroughtComponent/walkthrought_circuler_image.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/walkthrought/walkthroughtComponent/walkthrought_page_indecator.dart';

import '../../utils/colors.dart';
import '../../../../main.dart';
import '../../utils/image.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(2.seconds);
    Walkthrought().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .59,
                child: Stack(
                  children: [
                    // left 1st image
                    Positioned(
                      left: -size.width * .05,
                      top: size.width * .5,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage1,
                        height: size.width * .15,
                        width: size.width * .15,
                        rotate: .54,
                      ),
                    ),
                    // left 2nd image
                    Positioned(
                      left: -size.width * .07,
                      bottom: size.width * .25,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage2,
                        height: size.width * .23,
                        width: size.width * .23,
                        rotate: .55,
                      ),
                    ),
                    // center top image
                    Positioned(
                      left: size.width * .19,
                      top: size.width * .15,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage3,
                        height: size.width * .25,
                        width: size.width * .25,
                        rotate: .1,
                      ),
                    ),
                    // center middle image
                    Positioned(
                      left: size.width * .21,
                      top: size.width * .5,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage1,
                        width: size.width * .38,
                        height: size.width * .38,
                        rotate: .1,
                      ),
                    ),
                    // center last image
                    Positioned(
                      left: size.width * .19,
                      bottom: size.width * .02,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage2,
                        height: size.width * .20,
                        width: size.width * .20,
                        rotate: .1,
                      ),
                    ),
                    // last top image
                    Positioned(
                      left: size.width * .60,
                      top: size.width * .18,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage3,
                        width: size.width * .30,
                        height: size.width * .30,
                        rotate: .1,
                      ),
                    ),
                    Positioned(
                      right: size.width * .15,
                      top: size.width * .56,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage1,
                        height: size.width * .16,
                        width: size.width * .16,
                        rotate: .1,
                      ),
                    ),
          
                    // last center image
                    Positioned(
                      right: -size.width * .05,
                      bottom: size.width * .35,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage2,
                        width: size.width * .20,
                        height: size.width * .20,
                        rotate: 6,
                      ),
                    ),
                    Positioned(
                      right: size.width * .18,
                      bottom: size.width * .015,
                      child: WalkthroughtCirculerImage(
                        image: welcomeImage3,
                        height: size.width * .33,
                        width: size.width * .33,
                        rotate: .52,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * .1),
              WalkthroughtPageIndecator(
                text: "Welcome to",
                color: appStore.isDarkModeOn ? lightCoral : primaryBlueColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WalkthroughtPageIndecator(
                    text: "Reuse! 👋",
                    color: appStore.isDarkModeOn ? lightCoral : primaryBlueColor,
                  ),
                ],
              ),
              SizedBox(height: size.height * .1),
              Text(
                "The best real estate application to complete",
                style: secondaryTextStyle(),
              ),
              Text(
                "your life and family.",
                style: secondaryTextStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
