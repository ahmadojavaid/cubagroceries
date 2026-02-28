import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../component/custom_button.dart';
import '../utils/colors.dart';
import '../utils/image.dart';
import 'Auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> walkthroughData = [
    {
      "image": splash_2,
      "title": "Start Your Journey Towards A More Active Lifestyle",
    },
    {
      "image": splash_3,
      "title": "Find Nutrition Tips That Fit Your Lifestyle",
    },
    {
      "image": splash_4,
      "title": "A Community For You, Challenge Yourself",
    },
  ];

  void nextPage() {
    if (currentIndex < walkthroughData.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      AuthScreen().launch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: walkthroughData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  //TODO:
                  Image.network(
                    walkthroughData[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withValues(alpha: 0.3)),
                ],
              );
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: currentIndex == walkthroughData.length - 1
                ? SizedBox()
                : TextButton(
                    onPressed: () {
                      AuthScreen().launch(context, isNewTask: true);
                    },
                    child: Text(
                      'Skip',
                      style: boldTextStyle(color: limeColor, size: 16),
                    ),
                  ),
          ),
          Positioned(
            bottom: height * 0.07,
            left: width * 0.020,
            right: width * 0.020,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      Text(
                        walkthroughData[currentIndex]['title']!,
                        style: boldTextStyle(size: 24, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      12.height,
                      CustomDotIndicator(
                        currentIndex: currentIndex,
                        totalDots: walkthroughData.length,
                      ),
                    ],
                  ),
                ),
                20.height,
                Blur(
                  blur: 78,
                  borderRadius: BorderRadius.circular(25),
                  child: CustomButton(
                    text: currentIndex == walkthroughData.length - 1 ? 'Get Started' : 'Next',
                    onPressed: nextPage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  const CustomDotIndicator({super.key, required this.currentIndex, required this.totalDots});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        bool isActive = index == currentIndex;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: width * 0.005),
          width: isActive ? width * 0.12 : width * 0.05,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(width * 0.01),
          ),
        );
      }),
    );
  }
}
