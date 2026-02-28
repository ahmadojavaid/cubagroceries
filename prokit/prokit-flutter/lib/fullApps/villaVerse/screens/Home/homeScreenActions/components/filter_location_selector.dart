import 'package:flutter/material.dart';
import 'package:prokit_flutter/main.dart';

import '../../../../utils/colors.dart';

class FilterLocationSelector extends StatelessWidget {
  final List<String> locations;
  final String selected;
  final void Function(String) onSelect;
  final ExpansionTileController controller;

  const FilterLocationSelector({
    required this.locations,
    required this.selected,
    required this.controller,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: appStore.isDarkModeOn ? darkColor : lightColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            selected,
            style: TextStyle(
              color: selected == "Location" ? Colors.grey : appStore.isDarkModeOn ? lightColor : darkColor,
            ),
          ),
          children: locations.map((loc) {
            return ListTile(
              title: Text(loc),
              onTap: () {
                onSelect(loc);
                controller.collapse();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}