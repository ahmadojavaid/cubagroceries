import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../shop/screen/components/active_order_screen.dart';
import 'CanceledOrderScreen.dart';
import 'completed_order_screen.dart';

class OrderHomeScreen extends StatefulWidget {
  const OrderHomeScreen({super.key});

  @override
  State<OrderHomeScreen> createState() => _OrderHomeScreenState();
}

class _OrderHomeScreenState extends State<OrderHomeScreen> {
  int activeIndex = 0;

  void _changeContent(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Images.ic_appIcon, width: 30, height: 30),
                const Text(
                  "Orders",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    //
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            // Custom Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Active" Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeContent(0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: activeIndex == 0 ? PickColor.brownColor : PickColor.borderColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Active",
                          style: TextStyle(
                            color: activeIndex == 0 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // "Completed" Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeContent(1),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: activeIndex == 1 ? PickColor.brownColor : PickColor.borderColor,
                      ),
                      child: Center(
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            color: activeIndex == 1 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // "Canceled" Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => _changeContent(2),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: activeIndex == 2 ? PickColor.brownColor : PickColor.borderColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Canceled",
                          style: TextStyle(
                            color: activeIndex == 2 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Display Content Based on Selection
            Expanded(
              child: activeIndex == 0
                  ? const ActiveOrderScreen() // Display Active Orders
                  : activeIndex == 1
                      ? const CompletedOrderScreen() // Display Completed Orders
                      : const CanceledOrderScreen(), // Display Canceled Orders
            ),
          ],
        ),
      ),
    );
  }
}
