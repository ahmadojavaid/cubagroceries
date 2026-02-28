import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class SavedAddressComponent extends StatelessWidget {
  const SavedAddressComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: PickColor.brownColor),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: PopupMenuButton<int>(
        icon: const Icon(Icons.more_vert, color: PickColor.brownColor),
        offset: const Offset(0, 50),
        color: PickColor.whiteColor,
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 10),
                  Text("Set As Primary Address", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            const PopupMenuDivider(height: 1),
            const PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: PickColor.redColor),
                  SizedBox(width: 10),
                  Text("Delete Address", style: TextStyle(fontSize: 15, color: PickColor.redColor)),
                ],
              ),
            ),
          ];
        },
        onSelected: (int value) {
          // Handle the menu item selection here
          if (value == 1) {
            // Perform action for Option 1
          } else if (value == 2) {
            // Perform action for Option 2
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2, // Reduces shadow around popup menu
      ),
    );
  }
}
