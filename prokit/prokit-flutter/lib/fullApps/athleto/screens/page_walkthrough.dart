import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../component/custom_button.dart';
import '../utils/colors.dart';
import '../utils/image.dart';
import 'Auth/login_screen.dart';
import 'onboarding_screen.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> walkthroughData = [
    {
      "image": walkImage1,
      "title": "Find The Right Workout for What You Need",
    },
    {
      "image": walkImage2,
      "title": "Choose Proper Workout & Diet Plan to Stay Fit.",
    },
    {
      "image": walkImage3,
      "title": "Easily Track Your Daily Activity",
    },
  ];

  void _nextPage() {
    if (_currentPage < walkthroughData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      AuthScreen().launch(context, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: Column(
        children: [
          60.height,
          _currentPage < walkthroughData.length - 1
              ? Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      AuthScreen().launch(context);
                    },
                    child: Text("Skip", style: primaryTextStyle(size: 16, color: primaryColor)),
                  ),
                )
              : SizedBox(
                  height: 48,
                ),
          SizedBox(
            height: screenHeight * 0.7,
            width: screenWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 50,
                  //TODO:
                  child: Image.network(
                    logo,
                    color: white,
                    width: screenWidth * 0.9,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 1.2,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: walkthroughData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Spacer(),
                          //TODO:
                          Image.network(
                            walkthroughData[index]["image"]!,
                            width: screenWidth * 1.4,
                            height: screenHeight * 0.6,
                            fit: BoxFit.contain,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              walkthroughData[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: boldTextStyle(size: 25, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          40.height,
          CustomDotIndicator(currentIndex: _currentPage, totalDots: walkthroughData.length),
          14.height,
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CustomButton(color: limeColor, textcolor: black, onPressed: _nextPage, text: _currentPage == walkthroughData.length - 1 ? "Get Started" : "Next"),
          ),
        ],
      ),
    );
  }
}
