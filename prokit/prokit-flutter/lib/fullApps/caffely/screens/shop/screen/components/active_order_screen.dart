import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';

class ActiveOrderScreen extends StatefulWidget {
  const ActiveOrderScreen({super.key});

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    Row(
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
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Classic Brew", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                const Row(
                                  children: [
                                    Icon(Icons.storefront, size: 12),
                                    SizedBox(width: 5),
                                    Text("Caffely Astoria  Aromas"),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PickColor.brownColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: Text(
                                        "Pick Up",
                                        style: TextStyle(fontSize: 10, color: PickColor.brownColor, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18, color: PickColor.greyColor)
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: PickColor.borderColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Remind me 30 minutes earlier"),
                        Transform.scale(
                          scale: 0.6, // Adjust this value to change the size (e.g., 1.5 for 150%)
                          child: Switch(
                            value: isActive, // Make sure to pass the current state of `isActive`
                            onChanged: (value) {
                              setState(() {
                                isActive = !isActive; // Update `isActive` based on switch toggle
                              });
                            },
                            activeTrackColor: PickColor.brownColor,
                            activeColor: PickColor.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    Row(
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
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
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
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Classic Brew",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                const Row(
                                  children: [
                                    Icon(Icons.storefront, size: 12),
                                    SizedBox(width: 5),
                                    Text("Caffely Astoria  Aromas"),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PickColor.brownColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      child: Text(
                                        "Delivery",
                                        style: TextStyle(fontSize: 10, color: PickColor.brownColor, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 18, color: PickColor.greyColor)
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: PickColor.borderColor),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              elevation: 0,
                              side: const BorderSide(color: PickColor.brownColor),
                            ),
                            onPressed: () {
                              //
                            },
                            child: const Text(
                              "Cancle Order",
                              style: TextStyle(color: PickColor.brownColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              elevation: 0,
                              backgroundColor: PickColor.brownColor,
                            ),
                            onPressed: () {
                              //
                            },
                            child: const Text("Track Driver", style: TextStyle(color: PickColor.whiteColor)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
