// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';

Widget buildDateSelector({
  required String title,
  required DateTime date,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${date.day}/${date.month}/${date.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.width,
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: stayNestPrimaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
