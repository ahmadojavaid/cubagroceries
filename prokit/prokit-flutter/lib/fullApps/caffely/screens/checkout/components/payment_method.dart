import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../paymentmethods/screen/payment_method_screen.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: PickColor.greyColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(color: PickColor.borderColor),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
                  ),
                },
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(Icons.credit_card_outlined, size: 20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Payment",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Choose your payment method",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
