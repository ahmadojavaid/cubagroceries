import 'package:flutter/material.dart';

class SigninHelper extends StatelessWidget {
  final double height;
  final String imagepath;

  final Color backgroudColor;
  final Color? imgColor;

  const SigninHelper({
    super.key,
    required this.height,
    required this.imgColor,
    required this.backgroudColor,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height * 1.5,
      decoration: BoxDecoration(
        color: backgroudColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 214, 213, 213),
        ),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            imagepath,
            color: imgColor,
            height: height / 1.5,
            width: height / 1.5,
          ),
        ),
      ),
    );
  }
}
