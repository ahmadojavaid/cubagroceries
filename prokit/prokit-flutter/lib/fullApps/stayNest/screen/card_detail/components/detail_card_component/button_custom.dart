import 'package:flutter/material.dart';

Widget circleButton(
  IconData icon,
  VoidCallback onTap, {
  Color color = Colors.black,
}) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    child: IconButton(icon: Icon(icon, color: color), onPressed: onTap),
  );
}
