import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/checkout/screen/pickup_screen.dart';

import '../../../utils/colors.dart';
import 'deliver_detail_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isAllSelected = true;
  Map<String, dynamic>? selectedVoucher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                child: isAllSelected
                    ? PickupScreen(selectedVoucher: selectedVoucher)
                    : DeliverDetailScreen(
                        selectedVoucher: selectedVoucher,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
