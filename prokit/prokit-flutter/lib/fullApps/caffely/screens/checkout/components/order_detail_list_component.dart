import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'order_detail_component.dart';

class OrderDetailListComponent extends StatelessWidget {
  const OrderDetailListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PickColor.greyColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  CheckOutText.orderDetail,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: const BorderSide(color: PickColor.brownColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  ),
                  child: const Text(
                    CheckOutText.addMore,
                    style: TextStyle(color: PickColor.brownColor),
                  ),
                )
              ],
            ),
            const Divider(color: PickColor.greyColor),
            const SizedBox(height: 10),
            const OrderDetailComponent(),
            const Divider(color: PickColor.greyColor),
            const Text("Notes"),
            const Text("Less sugar please.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
