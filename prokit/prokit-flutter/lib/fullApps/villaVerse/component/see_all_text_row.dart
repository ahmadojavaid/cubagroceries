import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class SeeAllTextRow extends StatelessWidget {
  final String text;
  final VoidCallback voidCallback;

  const SeeAllTextRow({super.key, required this.text, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: voidCallback,
          child: Text(
            'See All',
            style: TextStyle(color: primaryBlueColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
