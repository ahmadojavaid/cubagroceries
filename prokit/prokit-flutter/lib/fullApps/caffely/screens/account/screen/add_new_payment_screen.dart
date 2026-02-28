import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class AddNewPaymentScreen extends StatelessWidget {
  const AddNewPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Payment", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              // You can define the QR scanner action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Card Number",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: PickColor.borderColor,
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: PickColor.blackTransparent),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: PickColor.blackTransparent),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  isDense: true,
                  hintText: "2640 4763 7569 8456",
                  hintStyle: TextStyle(color: PickColor.greyColor),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Account Holder Name",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const TextField(
                decoration: InputDecoration(
                  fillColor: PickColor.borderColor,
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: PickColor.blackTransparent),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: PickColor.blackTransparent),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  isDense: true,
                  hintText: "Andrew Ainsley",
                  hintStyle: TextStyle(color: PickColor.greyColor),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Expiry Date",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 60,
                          decoration: BoxDecoration(
                            color: PickColor.borderColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("06/28", style: TextStyle(fontSize: 15)),
                              Icon(Icons.calendar_month, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Space between the two columns
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "CVV",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: PickColor.borderColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("475", style: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(color: PickColor.borderColor),
              const SizedBox(height: 15),
              const Text(
                "Supported Payments:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.ic_mastercard),
                  Image.asset(Images.ic_visa),
                  Image.asset(Images.ic_amazon, height: 25),
                  Image.asset(Images.ic_americanExpress, height: 25),
                  Image.asset(Images.ic_mastercard),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            backgroundColor: PickColor.brownColor,
          ),
          onPressed: () {},
          child: const Text("Save", style: TextStyle(color: PickColor.whiteColor)),
        ),
      ),
    );
  }
}
