import 'package:flutter/material.dart';

import 'colors.dart';

class BottomButton extends StatelessWidget {
  final String btnText;
  final Function()? onTap;

  const BottomButton({
    super.key,
    required this.btnText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              backgroundColor: PickColor.brownColor,
            ),
            onPressed: onTap, // Correctly invoking the onTap callback
            child: Text(
              btnText,
              style: const TextStyle(color: PickColor.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
