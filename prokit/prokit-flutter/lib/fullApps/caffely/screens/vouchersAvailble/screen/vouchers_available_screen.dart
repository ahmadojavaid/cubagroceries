import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

final List<Map<String, dynamic>> voucherList = [
  {"title": "30% off - Limited time Offer!", "des": "Wake up and smell the saving! Enjoy a fantastic 30% discount on all our coffee creation.", "date": "31,2023", "transaction": "2.50", "code": "XGZ9V2"},
  {"title": "Early Bird Brews", "des": "Enjoy 20% off on all coffee orders before 10 AM", "date": "31,2023", "transaction": "2.50", "code": "XGZ9V2"},
  {"title": "Coffee Delight Await!", "des": "Embark on a coffee journey like no other! Introduction", "date": "24,2023", "transaction": "4.50", "code": "XGZ9V2"},
  {"title": "Weekend Coffee Fiesta!", "des": "Kick off the weekend with our Coffee Fiesta! Enjoy like...", "date": "26,2023", "transaction": "3.00", "code": "XGZ9V2"},
  {"title": "Weekend Refuel", "des": "15% off on all drinks every Saturday and Sunday", "date": "24,2023", "transaction": "2.50", "code": "XGZ9V2"},
  {"title": "Loyalty Perks", "des": "Double points on all purchases for our loyal customers.", "date": "22,2023", "transaction": "4.50", "code": "XGZ9V2"}
];

class VouchersAvailableScreen extends StatelessWidget {
  const VouchersAvailableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vouchers Available',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: voucherList.length,
          itemBuilder: (context, index) {
            final voucherData = voucherList[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucherData["title"],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    voucherData["des"],
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.timer, size: 20, color: PickColor.brownColor),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Valid Until:", style: TextStyle(fontSize: 10)),
                                Text(
                                  voucherData["date"],
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.credit_card_outlined, size: 20, color: PickColor.brownColor),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Min Transaction", style: TextStyle(fontSize: 10)),
                                Text(
                                  voucherData["transaction"],
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const SizedBox(
                        height: 28,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 1,
                        ),
                      ),
                      const SizedBox(width: 22),
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PickColor.brownColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context, voucherData);
                          }, // Correctly invoking the onTap callback
                          child: const Text(
                            "Use",
                            style: TextStyle(color: PickColor.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
