import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class CanceledOrderScreen extends StatefulWidget {
  const CanceledOrderScreen({super.key});

  @override
  State<CanceledOrderScreen> createState() => _CompletedOrderScreenState();
}

final List<Map<String, dynamic>> coffeList = [
  {"name": "Buleberry Bliss", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Minty Fresh Brew", "cafe": "Caffely Times Square", "btn": "Delivery"},
  {"name": "Smoky Espresso", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Zesty Cirtrus Delight", "cafe": "Caffely Broodway Brews", "btn": "pick up"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
];

class _CompletedOrderScreenState extends State<CanceledOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: coffeList.length,
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final coffee = coffeList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PickColor.borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    Images.img_coffeCup,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.5,
                                    child: Marquee(direction: Axis.horizontal,
                                      child: Text(
                                        coffee['name'],
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(Icons.storefront, size: 12),
                                      const SizedBox(width: 5),
                                      Text(coffee['cafe']),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PickColor.brownColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: Text(
                                        coffee['btn'],
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: PickColor.brownColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: PickColor.greyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
