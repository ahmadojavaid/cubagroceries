import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class AddExtraComponent extends StatefulWidget {
  final String category;

  const AddExtraComponent({
    super.key,
    required this.category,
  });

  @override
  State<AddExtraComponent> createState() => _AddExtraComponentState();
}

class _AddExtraComponentState extends State<AddExtraComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 5),
            const Text("(Optional)", style: TextStyle(color: PickColor.greyColor))
          ],
        ),
        const Row(
          children: [
            Text(
              "Max 1",
              style: TextStyle(fontSize: 15, color: PickColor.brownColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Icon(Icons.keyboard_arrow_up, color: PickColor.brownColor)
          ],
        )
      ],
    );
  }
}
