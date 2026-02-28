import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const DetailItem({super.key, required this.icon, required this.title});

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: stayNestPrimaryColor),
        4.height,
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
