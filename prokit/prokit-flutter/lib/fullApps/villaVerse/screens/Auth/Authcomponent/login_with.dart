import 'package:flutter/material.dart';

class LoginWith extends StatelessWidget {
  final String imgPath;
  final String text;
  final double height;
  final Color color;
  final Color? imgcolor;

  const LoginWith({
    super.key,
    required this.imgPath,
    required this.text,
    required this.height,
    required this.color,
    required this.imgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 214, 213, 213),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Image.network(
                  imgPath,
                  color: imgcolor,
                  width: height / 1.5,
                  height: height / 1.5,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 14, color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
