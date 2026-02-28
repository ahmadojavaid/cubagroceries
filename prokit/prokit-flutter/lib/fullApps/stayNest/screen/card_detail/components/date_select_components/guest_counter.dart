// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../../main.dart';
import '../../../../utils/colors.dart';

class GuestCounter extends StatelessWidget {
  final String title;
  final String subtitle;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const GuestCounter({
    super.key,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: appStore.isDarkModeOn
                  ? TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(fontWeight: FontWeight.bold),
            ),
            4.height,
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove_circle_outline, color: Colors.grey[700]),
            ),
            Text(
              '$count',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add_circle_outline, color: stayNestPrimaryColor),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(vertical: 8);
  }
}
