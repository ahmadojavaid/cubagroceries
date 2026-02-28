import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';

class ChooseDeliveryAddressScreen extends StatefulWidget {
  const ChooseDeliveryAddressScreen({super.key});

  @override
  State<ChooseDeliveryAddressScreen> createState() => _ChooseDeliveryAddressScreenState();
}

class _ChooseDeliveryAddressScreenState extends State<ChooseDeliveryAddressScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Delivery Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndex == 0 ? PickColor.brownColor : PickColor.borderColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Home",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PickColor.brownColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Main Address",
                                      style: TextStyle(
                                        color: PickColor.brownColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.share_outlined),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: PickColor.borderColor),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              "Andrew",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Contact: 1234567890",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("123, Home Street, City, ZIP-12345"),
                            selectedIndex == 0
                                ? const Icon(
                                    Icons.check,
                                    color: PickColor.brownColor,
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text("Pinpointed on map"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Address 2: Apartment
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedIndex == 1 ? PickColor.brownColor : PickColor.borderColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Apartment",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.share_outlined),
                          ],
                        ),
                        const Divider(color: PickColor.borderColor),
                        const Row(
                          children: [
                            Text(
                              "Andrew",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Contact: 1234567890",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Apartment Address, City, ZIP-12345"),
                            selectedIndex == 1
                                ? const Icon(
                                    Icons.check,
                                    color: PickColor.brownColor,
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text("Pinpointed on map"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PickColor.borderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(ChooseDeliveryAddress.momsHouse, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Icon(Icons.share_outlined),
                          ],
                        ),
                        const Divider(color: PickColor.borderColor),
                        const Row(
                          children: [
                            Text(
                              ChooseDeliveryAddress.momsHouseName,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(ChooseDeliveryAddress.momsHouseAddress),
                            selectedIndex == 2
                                ? const Icon(
                                    Icons.check,
                                    color: PickColor.brownColor,
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(ChooseDeliveryAddress.pinpointAlready),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomButton(
          btnText: "Ok",
          onTap: () {
            Navigator.pop(context, {
              "selectedAddressIndex": selectedIndex,
            });
          },
        ),
      ),
    );
  }
}
