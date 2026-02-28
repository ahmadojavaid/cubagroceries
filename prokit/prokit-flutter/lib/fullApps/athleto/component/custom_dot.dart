import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  const CustomDotIndicator({super.key, required this.currentIndex, required this.totalDots});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        bool isActive = index == currentIndex;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: isActive ? 50 : 20,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
