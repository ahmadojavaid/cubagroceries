import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../components/claim_fill_button_component.dart';

class SpecialOfferListScreen extends StatefulWidget {
  const SpecialOfferListScreen({super.key});

  @override
  State<SpecialOfferListScreen> createState() => _SpecialOfferListScreenState();
}

final List<Map<String, dynamic>> offerList = [
  {"title": "Early Bird Brews", "des": "Enjoy 20% off on all coffee orders before 10 Am!", "date": "Dec 31,2023", "transaction": "2.50"},
  {"title": "Caffeine Rush Hour", "des": "Get a free upgrade to a larger size an any espresso...", "date": "Dec 26,2023", "transaction": "3.00"},
  {"title": "Coffee & Cake Combo", "des": "Buy any coffee and get a slice of cake for half price", "date": "Dec 31,2023", "transaction": "3.00"},
  {"title": "Loyalty Perks", "des": "Double points on all purchase for our loyal customer", "date": "Dec 24,2023", "transaction": "3.50"},
  {"title": "Weekend Refuel", "des": "15% off on all drinks every Saturday and Sunday", "date": "Dec 28,2023", "transaction": "3.50"}
];

class _SpecialOfferListScreenState extends State<SpecialOfferListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          SpecialOfferText.specialOffer,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        shrinkWrap: true,
        itemCount: offerList.length,
        itemBuilder: (context, index) {
          final offerData = offerList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 145,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 160, 160, 160),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offerData["title"],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    offerData["des"],
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                SpecialOfferText.validUntil,
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                offerData["date"],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 20,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                offerData["transaction"],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 20,
                        ),
                      ),
                      const Expanded(child: ClaimFillButtonComponent()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
