import 'dart:math';

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../signin/screen/singin_home_screen.dart';
import '../model/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

final List<OnBoardingModel> onboardingList = [
  OnBoardingModel(
    "Get Your Coffee - Anytime, Anywhere",
    "Choose the way you want to enjoy your coffee with Caffely. Just a few taps on the app, and your coffee is ready for you",
    Images.img_onboarding1,
  ),
  OnBoardingModel(
    "Seamless Payment with Our Secure Wallet",
    "Say goodbye to hassle and hello to seamless transaction  with Caffely's secure wallet. Making payments has never been easier. Explore the World of Coffee Right Now.",
    Images.img_onboarding2,
  ),
  OnBoardingModel("Explore the World of Coffee Right Now.", "Dive into the fascinating world of coffee with Caffely. Discover unique and delightful coffee flavors one sip at a time. ", Images.img_onboarding3),
];

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                log(index);
                currentPage = index;
              });
            },
            itemCount: onboardingList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    color: PickColor.brownColor,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 650,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("${onboardingList[index].image}"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 350,
                      color: PickColor.whiteColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Wrap(
                              children: [
                                Text(
                                  "${onboardingList[index].title}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontFamily: PageViewText.fontFamily),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Wrap(
                              children: [
                                Text(
                                  "${onboardingList[index].subtitle}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: row(),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: currentPage < 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SingInHomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PickColor.brownColorLight,
                          foregroundColor: PickColor.brownColor,
                          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                        ),
                        child: const Text(PageViewText.skip),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (currentPage < 2) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PickColor.brownColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                        ),
                        child: const Text(SignInText.continueText),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SingInHomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PickColor.brownColor,
                        foregroundColor: PickColor.whiteColor,
                        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                      ),
                      child: const Text("Get Started"),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Dynamic row widget to show indicators based on current page
  Widget row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        currentPage == 0 ? const Icon(Icons.circle, size: 10, color: PickColor.brownColor) : const Icon(Icons.circle_outlined, size: 10, color: PickColor.greyColor),
        currentPage == 1 ? const Icon(Icons.circle, size: 10, color: PickColor.brownColor) : const Icon(Icons.circle_outlined, size: 10, color: PickColor.greyColor),
        currentPage == 2 ? const Icon(Icons.circle, size: 10, color: PickColor.brownColor) : const Icon(Icons.circle_outlined, size: 10, color: PickColor.greyColor),
      ],
    );
  }
}
