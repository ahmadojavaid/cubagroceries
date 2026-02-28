import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class StarIconComponent extends StatelessWidget {
  const StarIconComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(Icons.star, size: 16, color: PickColor.orange),
            Icon(Icons.star, size: 16, color: PickColor.orange),
            Icon(Icons.star, size: 16, color: PickColor.orange),
            Icon(Icons.star, size: 16, color: PickColor.orange),
            Icon(Icons.star_border, size: 16, color: PickColor.orange),
          ],
        ),
        SizedBox(width: 10),
        Icon(Icons.more_vert, size: 25)
      ],
    );
  }
}
