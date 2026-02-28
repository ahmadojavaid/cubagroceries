import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/health_offer_card_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  late PageController _controller;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  final List<Widget> _originalCards = [
    HealthOfferCard(
      imagePath: kiviLabAppImages.doctor,
      title: '20% Off on Health Checkups!',
      subtitle: 'Limited time offer. Book now.',
    ),
    HealthOfferCard(
      imagePath: kiviLabAppImages.doctor,
      title: 'Heart & Diabetes Package',
      subtitle: 'Stay healthy with regular checks.',
    ),
    HealthOfferCard(
      imagePath: kiviLabAppImages.doctor,
      title: 'Senior Citizen Plan',
      subtitle: 'Special care for elders.',
    ),
  ];

  List<Widget> get _loopedCards =>
      [_originalCards.last, ..._originalCards, _originalCards.first];

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1,
      viewportFraction: 0.9,
    );

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = _controller.page?.round() ?? 1;
      nextPage += 1;

      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _handlePageChanged(int index) {
    if (index == 0) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _controller.jumpToPage(_originalCards.length);
      });
    } else if (index == _originalCards.length + 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _controller.jumpToPage(1);
      });
    }

    setState(() {
      _currentPage = (index - 1) % _originalCards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: _loopedCards.length,
            onPageChanged: _handlePageChanged,
            itemBuilder: (context, index) {
              return _loopedCards[index];
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_originalCards.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 20 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? kiviLabAppColors.secondaryColor
                    : kiviLabAppColors.btn.withAlpha((0.3 * 255).toInt()),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
