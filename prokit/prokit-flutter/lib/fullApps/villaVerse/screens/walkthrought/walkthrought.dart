import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/walkthrought/walkthroughtComponent/indecator_circle.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/walkthrought/walkthroughtComponent/walkthought_image.dart';

import '../../utils/colors.dart';
import '../../utils/image.dart';
import '../Auth/sign_in.dart';
import 'walkthroughtComponent/circuler_image.dart';
import '../../../../main.dart';
import 'walkthroughtComponent/walkthrought_page_indecator.dart';

class Walkthrought extends StatefulWidget {
  const Walkthrought({super.key});

  @override
  State<Walkthrought> createState() => _WalkthroughtState();
}

class _WalkthroughtState extends State<Walkthrought> {
  final List<Map<String, dynamic>> _page = [
    {
      "image": welcomeImage1,
      "title": '''Thousands of the
best real estete at
affordable prices''',
    },
    {
      "image": welcomeImage2,
      "title": '''Book a real estate
quickly and easily
with one click''',
    },
    {
      "image": welcomeImage3,
      "title": '''Let's find the real
estate that suits you
right now!''',
    },
  ];
  int selectedIndex = 0;

  void _nextPage() {
    if (selectedIndex < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else if (selectedIndex == 2) {
      SignIn().launch(context);
    }
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: Observer(builder: (_) {
        return Stack(
          children: [
            PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemCount: _page.length,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * .05),
                    SizedBox(
                      height: size.height * .6,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(0, 0),
                            child: WalkthoughtImage(
                                imgPath: _page[index]['image'],
                                height: size.height * .36,
                                width: size.width * .75),
                          ),
                          Positioned(
                            top: size.width * .25,
                            left: size.width * .12,
                            child: CirculerImage(height: size.width * .09),
                          ),
                          Positioned(
                            top: size.width * .15,
                            left: size.width * .4,
                            child: CirculerImage(height: size.width * .04),
                          ),
                          Positioned(
                            top: size.width * .20,
                            right: size.width * .25,
                            child: CirculerImage(height: size.width * .04),
                          ),
                          Positioned(
                            top: size.width * .30,
                            right: size.width * .1,
                            child: CirculerImage(height: size.width * .06),
                          ),
                          Positioned(
                            top: size.width * .5,
                            left: size.width * .1,
                            child: CirculerImage(height: size.width * .025),
                          ),
                          Positioned(
                            bottom: size.width * .5,
                            left: size.width * .10,
                            child: CirculerImage(height: size.width * .035),
                          ),
                          Positioned(
                            bottom: size.width * .22,
                            left: size.width * .25,
                            child: CirculerImage(height: size.width * .09),
                          ),
                          Positioned(
                            bottom: size.width * .22,
                            right: size.width * .25,
                            child: CirculerImage(height: size.width * .03),
                          ),
                          Positioned(
                            top: size.width * .5,
                            right: size.width * .08,
                            child: CirculerImage(height: size.width * .03),
                          ),
                          Positioned(
                            bottom: size.width * .5,
                            right: size.width * .08,
                            child: CirculerImage(height: size.width * .03),
                          ),
                        ],
                      ),
                    ),
                    WalkthroughtPageIndecator(
                        text: _page[index]['title'],
                        color: appStore.isDarkModeOn
                            ? lightColor
                            : primaryBlueColor),
                  ],
                );
              },
            ),
            Positioned(
              left: size.width * .35,
              right: size.width * .35,
              bottom: 100,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IndecatorCircle(
                    height: 10,
                    width: selectedIndex == 0 ? 40 : 10,
                    color:
                        selectedIndex == 0 ? primaryBlueColor : hintTextColor),
                SizedBox(width: 10),
                IndecatorCircle(
                    height: 10,
                    width: selectedIndex == 1 ? 40 : 10,
                    color:
                        selectedIndex == 1 ? primaryBlueColor : hintTextColor),
                SizedBox(width: 10),
                IndecatorCircle(
                    height: 10,
                    width: selectedIndex == 2 ? 40 : 10,
                    color:
                        selectedIndex == 2 ? primaryBlueColor : hintTextColor),
              ]),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppButton(
                text: _page.length == 2
                    ? "Get Started"
                    : selectedIndex == 2
                        ? "Get Started"
                        : "Next",
                color: primaryBlueColor,
                textStyle: boldTextStyle(color: Colors.white),
                width: context.width(),
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(50)),
                onTap: _nextPage,
              ).paddingSymmetric(horizontal: 16, vertical: 20),
            )
          ],
        );
      }),
    );
  }
}
