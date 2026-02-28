import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/checkout/screen/pick_time_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'delivery_at_time_Screen.dart';

class PickupAtTimeScreen extends StatefulWidget {
  const PickupAtTimeScreen({super.key});

  @override
  State<PickupAtTimeScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<PickupAtTimeScreen> {
  bool isAllSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          CheckOutText.checkout,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isAllSelected ? PickColor.brownColor : PickColor.borderColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Pick up",
                          style: TextStyle(
                            color: isAllSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: !isAllSelected ? PickColor.brownColor : PickColor.borderColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Delivery",
                          style: TextStyle(
                            color: !isAllSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isAllSelected ? const PickTimeScreen() : const DeliveryAtTimeScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
