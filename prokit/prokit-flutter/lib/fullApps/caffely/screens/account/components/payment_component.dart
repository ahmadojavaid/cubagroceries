import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding around the content
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Expiry Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 60,
                    decoration: BoxDecoration(
                      color: PickColor.greyColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("06/28", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Icon(Icons.calendar_month),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16), // Space between the two columns
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CVV",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: PickColor.greyColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("475", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
