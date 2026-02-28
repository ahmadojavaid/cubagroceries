import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class FilterOptionChips extends StatelessWidget {
  final List<dynamic> options;
  final int selectedIndex;
  final void Function(int) onTap;

  const FilterOptionChips({
    required this.options,
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? primaryBlueColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryBlueColor),
              ),
              alignment: Alignment.center,
              child: Text(
                options[index],
                style: TextStyle(
                  color: isSelected ? lightColor : primaryBlueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
