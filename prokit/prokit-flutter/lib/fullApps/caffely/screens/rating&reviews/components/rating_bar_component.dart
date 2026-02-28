import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

Widget buildRatingBar(int starCount, double barValue) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(starCount.toString()),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: barValue,
            backgroundColor: PickColor.borderColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: PickColor.brownColor,
            minHeight: 8,
          ),
        ),
      ],
    ),
  );
}
