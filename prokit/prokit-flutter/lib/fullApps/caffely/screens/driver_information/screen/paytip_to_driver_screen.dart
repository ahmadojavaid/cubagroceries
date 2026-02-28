import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/driver_information/screen/rate_shop_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../component/bottombarButton_component.dart';
import 'call_with_driver_screen.dart';

class PayTipToDriverScreen extends StatefulWidget {
  final int rating;

  const PayTipToDriverScreen({super.key, required this.rating});

  @override
  State<PayTipToDriverScreen> createState() => _PayTipToDriverScreenState();
}

class _PayTipToDriverScreenState extends State<PayTipToDriverScreen> {
  final List tipAmount = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int? selectedTipIndex = 1; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      Images.img_driver,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Wow ${widget.rating} Star! 🤩",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Do you want to add additional tip to make your driver's day?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: PickColor.greyColor),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(tipAmount.length, (index) {
                      final tip = tipAmount[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTipIndex = index; // Update the selected index
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: PickColor.borderColor),
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            color: selectedTipIndex == index ? PickColor.brownColor : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '\$$tip',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedTipIndex == index ? PickColor.whiteColor : PickColor.blackColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CallWithDriverScreen()),
                      );
                    },
                    child: const Text(
                      "Call your driver",
                      style: TextStyle(fontSize: 15, color: PickColor.brownColor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            left: 16.0,
            child: BottomBarButtonComponent(
              btnFirst: "No,Thanks",
              btnSecond: "Paytip",
              btnFirstOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RateShopScreen()),
                );
              },
              btnSecondOnTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RateShopScreen()),
                ),
              },
            ),
          )
        ],
      ),
    );
  }
}
