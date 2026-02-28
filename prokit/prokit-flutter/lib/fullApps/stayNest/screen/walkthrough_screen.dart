import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../store/page_store.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import 'auth/view/sign_in_screen.dart';

class WalkthroughScreen extends StatelessWidget {
  WalkthroughScreen({super.key});

  final PageStore _store = PageStore();

  final List<Map<String, String>> walkthroughData = [
    {
      'image': workthrogh1,
      'title': 'Easy way to book hotels with us',
      'subtitle': 'It is a long established fact that a reader will be distracted by the readable content.',
    },
    {
      'image': workthrogh2,
      'title': 'Discover and find your perfect healing',
      'subtitle': 'It is a long established fact that a reader will be distracted by the readable content.',
    },
    {
      'image': workthrogh3,
      'title': 'Giving the best deal just for you',
      'subtitle': 'It is a long established fact that a reader will be distracted by the readable content.',
    },
  ];

  void _nextPage(BuildContext context) {
    if (_store.currentPage < _store.lastPage) {
      _store.controller.nextPage(
        duration: 300.milliseconds,
        curve: Curves.easeInOut,
      );
    } else {
      LoginScreen().launch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = context.height();
    final double screenWidth = context.width();
    final double imageHeight = screenHeight * 0.78;

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      body: Observer(
        builder: (_) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  height: imageHeight,
                  width: screenWidth,
                  child: PageView.builder(
                    controller: _store.controller,
                    onPageChanged: _store.setPage,
                    itemCount: walkthroughData.length,
                    itemBuilder: (context, index) {
                      final item = walkthroughData[index];
                      return Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        width: screenWidth,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: screenHeight * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? black : white,
                    borderRadius: radiusOnly(topLeft: 30, topRight: 30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          walkthroughData.length,
                          (index) => AnimatedContainer(
                            duration: 300.milliseconds,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 4,
                            width: _store.currentPage == index ? 35 : 8,
                            decoration: BoxDecoration(
                              color: _store.currentPage == index ? stayNestPrimaryColor : Colors.grey.shade400,
                              borderRadius: radius(12),
                            ),
                          ),
                        ),
                      ),
                      16.height,
                      Text(
                        walkthroughData[_store.currentPage]['title']!,
                        textAlign: TextAlign.center,
                        style: boldTextStyle(
                          size: 30,
                          color: appStore.isDarkModeOn ? whiteColor : blackColor,
                        ),
                      ),
                      12.height,
                      Text(
                        walkthroughData[_store.currentPage]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: secondaryTextStyle(size: 14),
                      ),
                      30.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              LoginScreen().launch(context);
                            },
                            child: Text(
                              "Skip",
                              style: primaryTextStyle(
                                color: stayNestPrimaryColor,
                                size: 16,
                              ),
                            ),
                          ),
                          AppButton(
                            text: _store.currentPage == _store.lastPage ? "Get Started" : "",
                            textStyle: primaryTextStyle(color: white, size: 16),
                            color: stayNestPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 14,
                            ),
                            onTap: () => _nextPage(context),
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: radius(12),
                            ),
                            child: _store.currentPage == _store.lastPage
                                ? null
                                : Row(
                                    children: [
                                      Text(
                                        "Next ",
                                        style: primaryTextStyle(
                                          color: white,
                                          size: 16,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_sharp,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
