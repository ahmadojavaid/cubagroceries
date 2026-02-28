import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({super.key});

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

final List<Map<String, dynamic>> coffeList = [
  {"name": "Buleberry Bliss", "cafe": "Caffely Astoria Aromas", "btn": "pick up"},
  {"name": "Minty Fresh Brew", "cafe": "Caffely Times Square", "btn": "Delivery"},
  {"name": "Smoky Espresso", "cafe": "Caffely Astoria Aromas", "btn": "pick up"},
  {"name": "Zesty Cirtrus Delight", "cafe": "Caffely Broodway Brews", "btn": "pick up"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"},
  {"name": "Raspberry Rose Latte", "cafe": "Caffely Astoria Aromas", "btn": "Delivery"}
];

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: coffeList.length,
              itemBuilder: (context, index) {
                final coffee = coffeList[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.45, 
                                      child: Marquee(child: Text(coffee['cafe'],maxLines: 1,overflow: TextOverflow.visible,))),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
