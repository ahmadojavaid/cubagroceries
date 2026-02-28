import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class BottomBarButtonComponent extends StatefulWidget {
  final String btnFirst;
  final String btnSecond;
  final Function()? btnFirstOnTap;
  final Function() btnSecondOnTap;

  const BottomBarButtonComponent({
    super.key,
    required this.btnFirst,
    required this.btnSecond,
    this.btnFirstOnTap,
    required this.btnSecondOnTap,
  });

  @override
  State<BottomBarButtonComponent> createState() => _BottomBarButtonComponentState();
}

class _BottomBarButtonComponentState extends State<BottomBarButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              backgroundColor: PickColor.borderColor,
            ),
            onPressed: widget.btnFirstOnTap ??
                () {
                  Navigator.pop(context);
                },
            child: Text(
              widget.btnFirst,
              style: const TextStyle(color: PickColor.brownColor),
            ),
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              backgroundColor: PickColor.brownColor,
            ),
            onPressed: widget.btnSecondOnTap,
            child: Text(
              widget.btnSecond,
              style: const TextStyle(color: PickColor.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
