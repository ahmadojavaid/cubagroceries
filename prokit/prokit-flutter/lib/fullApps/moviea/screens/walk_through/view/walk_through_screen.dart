import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../auth/view/sign_in.dart';
import '../model/walk_through_model.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List<WalkThroughModel> pages = [];

  int currentPosition = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    pages.add(
      WalkThroughModel(
        title: 'Find the latest and greatest movie here',
        subTitle: 'Find new releases movies and buy tickets on see details events.',
        img: walkImg1,
      ),
    );
    pages.add(
      WalkThroughModel(
        title: 'Enjoy your favourite movie with us',
        subTitle: 'Online movie ticket bookings for the Bollywood, Hollywood showing near you.',
        img: walkImg2,
      ),
    );
    pages.add(
      WalkThroughModel(
        title: 'Book your favourite movie ticket here',
        subTitle: 'A movie or film is a type of visual art that  tell stories ond teach people something.',
        img: walkImg3,
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = context.height();
    double screenWidth = context.width();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: pages[currentPosition].title.validate().split(' ').sublist(0, 2).join(' '),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '  ',
                      ),
                      TextSpan(
                        text: pages[currentPosition].title.validate().split(' ').sublist(2, pages[currentPosition].title.validate().split(' ').length - 2).join(' '),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '  ',
                      ),
                      TextSpan(
                        text: pages[currentPosition].title.validate().split(' ').sublist(pages[currentPosition].title.validate().split(' ').length - 2).join(' '),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(pages[currentPosition].subTitle.validate(), style: secondaryTextStyle(size: 20), textAlign: TextAlign.left).paddingOnly(top: 16),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: movieaPrimaryColor,
                    dotColor: lightGray,
                    dotHeight: 8,
                    dotWidth: 10,
                    spacing: 10,
                  ),
                ).paddingOnly(top: 16),
                GestureDetector(
                  onTap: () async {
                    if (currentPosition == 2) {
                      const SignInPageScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                    } else {
                      pageController.nextPage(duration: 500.milliseconds, curve: Curves.linearToEaseOut);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(25)),
                    child: Image.network(walkIcon),
                  ),
                ).paddingOnly(top: 16),
              ],
            ).paddingOnly(left: 16, right: 16, top: 16),
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: screenHeight * 0.65,
                width: screenWidth,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return Image.network(pages[index].img.validate(), fit: BoxFit.cover);
                  },
                  onPageChanged: (i) {
                    currentPosition = i;
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
