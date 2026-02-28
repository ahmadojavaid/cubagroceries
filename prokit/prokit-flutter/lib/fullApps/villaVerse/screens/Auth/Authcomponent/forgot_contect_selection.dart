import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class ForgotContectSelection extends StatelessWidget {
  final IconData icon;
  final double height;
  final String toptext;
  final String bottomtext;
  final Color? borderColor;
  final Color containerColor;
  final Color backGroundColor;

  const ForgotContectSelection({
    super.key,
    required this.height,
    required this.icon,
    required this.bottomtext,
    required this.toptext,
    required this.containerColor,
    this.borderColor,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: borderColor != null
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: borderColor!),
            )
          : null,
      elevation: 2,
      color: backGroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: height,
                  width: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: containerColor,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: lightColor,
                      size: height * .5,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toptext,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      bottomtext,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
