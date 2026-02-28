import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final bool isDarkMode;
  final Function(String) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.isDarkMode,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => 5.width,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return ChoiceChip(
            showCheckmark: false,
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => onCategorySelected(category),
            selectedColor: stayNestPrimaryColor,
            backgroundColor: isDarkMode ? Color.fromARGB(255, 33, 32, 32) : Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : stayNestPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: isDarkMode ? Colors.transparent : stayNestPrimaryColor,
                width: 1.5,
              ),
            ),
          );
        },
      ),
    );
  }
}
