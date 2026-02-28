import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class UseButtonComponent extends StatefulWidget {
  const UseButtonComponent({super.key});

  @override
  State<UseButtonComponent> createState() => _UseButtonComponentState();
}

class _UseButtonComponentState extends State<UseButtonComponent> {
  bool _isUsed = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isUsed = !_isUsed;
        });
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: _isUsed ? PickColor.brownColor : PickColor.whiteColor,
        side: BorderSide(color: _isUsed ? PickColor.brownColor : PickColor.blackColor),
        minimumSize: const Size(40, 35),
        foregroundColor: _isUsed ? PickColor.whiteColor : PickColor.blackColor,
      ),
      child: _isUsed ? const Text("Use") : const Text("Used"),
    );
  }
}
