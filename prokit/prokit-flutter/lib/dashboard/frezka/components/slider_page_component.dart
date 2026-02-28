import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'dart:async';
import 'dart:math';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';


class FancyImageCarousel extends StatefulWidget {
  const FancyImageCarousel({super.key});

  @override
  State<FancyImageCarousel> createState() => _FancyImageCarouselState();
}

class _FancyImageCarouselState extends State<FancyImageCarousel> {
  late PageController _controller;
  late Timer _timer;

  double _currentPage = 0.0;
  int _activePage = 0;

  final List<String> imageUrls = [
    frezkaAppImages.slider1,
    frezkaAppImages.slider2,
    frezkaAppImages.slider3,
  ];

  final List<Map<String, String>> texts = [
    {'title': 'Discover Your Style', 'subtitle': '#FREESALON'},
    {'title': 'Fresh Looks Everyday', 'subtitle': '#FREESALON'},
    {'title': 'Exclusive Deals', 'subtitle': '#FREESALON'},
  ];

  List<String> get loopedImages => [
    imageUrls.last,
    ...imageUrls,
    imageUrls.first,
  ];
  List<Map<String, String>> get loopedTexts => [
    texts.last,
    ...texts,
    texts.first,
  ];

  @override
  void initState() {
    super.initState();

    _controller = PageController(viewportFraction: 0.75, initialPage: 1);

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
        _activePage = (_controller.page!.round() - 1) % imageUrls.length;
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage = _controller.page!.round() + 1;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _activePage == index ? 12 : 8,
      height: _activePage == index ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _activePage == index ? frezlaAppColor.deepPurple : frezlaAppColor.grey400,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationListener<ScrollEndNotification>(
          onNotification: (notification) {
            final page = _controller.page!.round();

            if (page == 0) {
              Future.microtask(() => _controller.jumpToPage(imageUrls.length));
            } else if (page == loopedImages.length - 1) {
              Future.microtask(() => _controller.jumpToPage(1));
            }
            return true;
          },
          child: SizedBox(
            height: 180,
           width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _controller,
              itemCount: loopedImages.length,
              itemBuilder: (context, index) {
                double scale = max(0.9, 1 - (_currentPage - index).abs() + 0.1);
                return Transform.scale(
                  scale: scale,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            loopedImages[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  frezlaAppColor.black.withAlpha((0.5 * 255).toInt()),
                                  frezlaAppColor.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 20,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              txtWidget(
                                loopedTexts[index]['title']!,
                                20,
                                FontWeight.w600,
                                frezlaAppColor.white,
                              ),
                              const SizedBox(height: 4),
                              txtWidget(
                                loopedTexts[index]['subtitle']!,
                                12,
                                FontWeight.w600,
                                frezlaAppColor.priceTxtColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imageUrls.length, buildDot),
        ),
      ],
    );
  }
}
