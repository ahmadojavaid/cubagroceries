import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ClaimFillButtonComponent extends StatefulWidget {
  const ClaimFillButtonComponent({super.key});

  @override
  State<ClaimFillButtonComponent> createState() => _ClaimFillButtonComponentState();
}

class _ClaimFillButtonComponentState extends State<ClaimFillButtonComponent> {
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: const Size(100, 35),
        // Set a fixed size for consistent width
        backgroundColor: _isSelected ? PickColor.brownColor : PickColor.whiteColor,
        side: BorderSide(color: _isSelected ? PickColor.brownColor : PickColor.blackColor),
        foregroundColor: _isSelected ? PickColor.whiteColor : PickColor.blackColor,
      ),
      child: FittedBox(
        child: Text(_isSelected ? "Claim" : "Claimed"),
      ),
    );
  }
}
