import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class OrderDetailComponent extends StatelessWidget {
  const OrderDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 212, 211, 211),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(3, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    Images.img_coffeCup,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CheckOutText.classicBrew,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(CheckOutText.hot, style: TextStyle(fontSize: 12)),
              Divider(color: Colors.grey),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(CheckOutText.basePrice, style: TextStyle(fontWeight: FontWeight.bold)), Text(CheckOutText.basePriceAmount, style: TextStyle(fontWeight: FontWeight.bold))],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(CheckOutText.sizeGrande), Text(CheckOutText.sizeGrandePrice)],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(CheckOutText.skimMilk), Text(CheckOutText.skimMilkPrice)],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(CheckOutText.hazelnut),
                      Text(CheckOutText.hazelnutPrice),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(CheckOutText.crumble),
                      Text(CheckOutText.crumblePrice),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CheckOutText.subtotal,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        CheckOutText.subtotalPrice,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
        const Icon(Icons.edit, size: 20),
      ],
    );
  }
}
