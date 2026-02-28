import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  Map<String, dynamic>? selectedPaymentData = {
    "image": Icons.wallet,
    "text": "My Wallet",
    "price": "\$948.50",
  };

  final List<Map<String, dynamic>> paymentCardList = [
    {"image": Images.img_paypalLogo, "text": "Paypal"},
    {"image": Images.img_googleLogo, "text": "Google Pay"},
    {"image": Images.img_applePayLogo, "text": "Apple Pay"},
    {"image": Images.img_mastercardLogo, "text": "Master Card"},
    {"image": Images.img_visapay, "text": "Visa"},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allPaymentOptions = [
      {"image": Icons.wallet, "text": "My Wallet", "price": "\$948.50"},
      ...paymentCardList,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: ListView.builder(
              itemCount: allPaymentOptions.length,
              itemBuilder: (context, index) {
                final paymentData = allPaymentOptions[index];
                final bool isSelected = selectedPaymentData == paymentData;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPaymentData = paymentData;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: isSelected ? PickColor.brownColor : PickColor.blackColor),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (index == 0) // For My Wallet
                                Icon(
                                  paymentData["image"],
                                  size: 30,
                                  color: PickColor.brownColor,
                                )
                              else
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                                  child: Image.network(
                                    paymentData["image"],
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              const SizedBox(width: 10),
                              Text(
                                paymentData["text"],
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (index == 0)
                            Text(
                              paymentData["price"],
                              style: const TextStyle(
                                color: PickColor.brownColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          if (isSelected) const Icon(Icons.check, color: PickColor.brownColor),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PickColor.brownColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                ),
                onPressed: () {
                  if (selectedPaymentData != null) {
                    Navigator.pop(context, selectedPaymentData);
                  }
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
