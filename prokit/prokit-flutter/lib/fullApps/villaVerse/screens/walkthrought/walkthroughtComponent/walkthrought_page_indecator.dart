import 'package:flutter/material.dart';

class WalkthroughtPageIndecator extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? iconData;

  const WalkthroughtPageIndecator({super.key, required this.text, required this.color, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 25, color: color, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Icon(iconData),
      ],
    );
  }
}
