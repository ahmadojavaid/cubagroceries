import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class PaymentDetailComponent extends StatelessWidget {
  const PaymentDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PickColor.greyColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Divider(color: PickColor.borderColor),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Grand Subtotal"),
                Text("\$6.00"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Service fee"),
                Text("\$1.00"),
              ],
            ),
            SizedBox(height: 10),
            Divider(color: PickColor.borderColor),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Payment"),
                Text("\$7.00"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
