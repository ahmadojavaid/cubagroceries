import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import 'call_with_driver_screen.dart';
import 'chat_with_driver_screen.dart';

class DriverInformationScreen extends StatelessWidget {
  const DriverInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          DriverInformationText.driverInformation,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                Images.img_driver,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              DriverInformationText.driverName,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DriverInformationText.driverPhone,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 10),
                Icon(Icons.copy, size: 15)
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PickColor.borderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: PickColor.borderColor),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Icon(Icons.star_outline),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "4.9",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          const Text("Ratings")
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: PickColor.borderColor),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Icon(Icons.card_travel_outlined),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            DriverInformationText.orderCount,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          const Text(DriverInformationText.orders)
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: PickColor.borderColor),
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: const Icon(Icons.access_time),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            DriverInformationText.yearCount,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          const Text(DriverInformationText.years)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PickColor.borderColor),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DriverInformationText.memberSince),
                          Text(
                            DriverInformationText.memberSinceDate,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DriverInformationText.motorCycleModel),
                          Text(
                            DriverInformationText.motorCycleModelName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DriverInformationText.plate),
                          Text(
                            DriverInformationText.plateNumber,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 35, right: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: PickColor.redColor),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: const Center(
                  child: Text("X", style: TextStyle(fontSize: 20, color: PickColor.redColor)),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatWithDriverScreen()),
                ),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: PickColor.brownColor),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(
                    Icons.message_rounded,
                    color: PickColor.brownColor,
                    size: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CallWithDriverScreen()),
                ),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: PickColor.brownColor),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Icon(Icons.call, color: PickColor.brownColor, size: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
