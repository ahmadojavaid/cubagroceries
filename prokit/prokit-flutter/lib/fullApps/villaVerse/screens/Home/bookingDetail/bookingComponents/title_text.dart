import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ).paddingSymmetric(horizontal: 16);
  }
}
