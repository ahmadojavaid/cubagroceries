import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final Color? color;

  const SocialButton({
    super.key,
    required this.onPressed,
    required this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            image,
            width: 20,
            height: 20,
            color: color,
          )),
    );
  }
}
