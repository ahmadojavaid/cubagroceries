import 'dart:async'; // Add this import for Timer

import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../specialoffer/screen/specialoffer_screen.dart';
import 'imageplaceholder_component.dart';

class HomeCarouselComponent extends StatefulWidget {
  final String? imagePath;

  const HomeCarouselComponent({super.key, this.imagePath});

  @override
  State<HomeCarouselComponent> createState() => _HomeCarouselComponentState();
}

class _HomeCarouselComponentState extends State<HomeCarouselComponent> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> _crousel;
  int _activePage = 0;
  List<String> imageCrousel = [
    Images.img_coffeeCarusel1,
    Images.img_coffeeCarusel2,
    Images.img_coffeeCarusel8,
    Images.img_coffeeCarusel11,
  ];

  Timer? _timer; // Declare a timer

  @override
  void initState() {
    super.initState();

    _crousel = List.generate(
      imageCrousel.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ImagePlaceholderComponent(
          imagePath: imageCrousel[index],
          fit: BoxFit.cover,
        ),
      ),
    );

    // Set up the timer for automatic scrolling
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_activePage < imageCrousel.length - 1) {
        _activePage++;
      } else {
        _activePage = 0;
      }
      _pageController.animateToPage(
        _activePage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageCrousel.length,
                onPageChanged: (value) {
                  setState(() {
                    _activePage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SpecialOfferScreen()),
                      );
                    },
                    child: _crousel[index],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Container(
                color: PickColor.blackTransparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _crousel.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: _activePage == index ? PickColor.whiteColor : PickColor.greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
