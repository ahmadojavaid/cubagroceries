import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

final List<Map<String, dynamic>> transactionHistory = [
  {'name': 'Classic Brew', 'price': '4.20', 'date': 'Dec 22,2023 . 09:41.20 AM', 'payMethod': 'Caffely Wallet'},
  {'name': 'Classic Brew', 'price': '3.20', 'date': 'Dec 22,2023 . 09:41.15 AM', 'payMethod': 'Caffely Wallet'},
  {'name': 'Top Up Wallet', 'price': '50.00', 'date': 'Dec 20,2023 . 14:25.37 PM', 'payMethod': 'Mastercard Wallet'},
  {'name': 'Blueberry Bliss', 'price': '5.50', 'date': 'Dec 19,2023 . 19:20.19 PM', 'payMethod': 'PayPal'},
  {'name': 'Minty Fresh Brew', 'price': '4.50', 'date': 'Dec 18,2023 . 20:01.40 PM', 'payMethod': 'PayPal'},
  {'name': 'Berry Bliss', 'price': '6.50', 'date': 'Dec 18,2023 . 05:40.20 AM', 'payMethod': 'American Express'},
  {'name': 'Smoky Espresso', 'price': '4.00', 'date': 'Dec 17,2023 . 10:07.38 AM', 'payMethod': 'Visa'},
  {'name': 'Top Up Wallet', 'price': '100.00', 'date': 'Dec 15,2023 . 13:58.20 AM', 'payMethod': 'Apple Pay'},
  {'name': 'Zesty Citrus Delight', 'price': '4.50', 'date': 'Dec 14,2023 . 16:44.57 PM', 'payMethod': 'Caffely Wallet'},
  {'name': 'Raspberry Rose Latte', 'price': '5.50', 'date': 'Dec 13,2023 . 05:40.20 AM', 'payMethod': 'Google Pay'},
];

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: PickColor.blackColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: ListView.builder(
          itemCount: transactionHistory.length,
          itemBuilder: (context, index) {
            final transaction = transactionHistory[index];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transaction['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text("-\$ ${transaction['price']}", style: const TextStyle(fontSize: 18))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(transaction['date']), Text(transaction['payMethod'])],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(color: PickColor.borderColor)
              ],
            );
          },
        ),
      ),
    );
  }
}
