import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/wallet/screen/topup_amount_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/wallet/screen/transaction_history.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../home/screen/home_page_screen.dart';

class WalletHomeScreen extends StatefulWidget {
  const WalletHomeScreen({super.key});

  @override
  State<WalletHomeScreen> createState() => _WalletHomeScreenState();
}

final List<Map<String, dynamic>> transactionHistory = [
  {'name': 'Classic Brew', 'price': '4.20', 'date': 'Dec 22,2023 . 09:41.20 AM', 'payMethod': 'Caffely Wallet'},
  {'name': 'Classic Brew', 'price': '3.20', 'date': 'Dec 22,2023 . 09:41.15 AM', 'payMethod': 'Caffely Wallet'},
  {'name': 'Top Up Wallet', 'price': '50.00', 'date': 'Dec 20,2023 . 14:25.37 PM', 'payMethod': 'Mastercard Wallet'},
  {'name': 'Blueberry Bliss', 'price': '5.50', 'date': 'Dec 19,2023 . 19:20.19 PM', 'payMethod': 'PayPal'},
  {'name': 'Minty Fresh Brew', 'price': '4.50', 'date': 'Dec 18,2023 . 20:01.40 PM', 'payMethod': 'PayPal'},
  {'name': 'Berry Bliss', 'price': '6.50', 'date': 'Dec 18,2023 . 05:40.20 AM', 'payMethod': 'American Express'},
];

class _WalletHomeScreenState extends State<WalletHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16, top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Images.ic_appIcon,
                  width: 30,
                  height: 30,
                ),
                const Text(
                  "Wallet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePageScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.search, color: PickColor.blackColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Wallet Information Card
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: PickColor.brownColor,
                  ),
                ),
                const Positioned(
                  top: 20,
                  left: 30,
                  child: Text(
                    "Andrew Ainsley",
                    style: TextStyle(fontSize: 20, color: PickColor.whiteColor),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 120,
                  child: Image.asset(
                    Images.ic_mastercard, //TODO image var
                    height: 30,
                    width: 20,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 95,
                  child: Image.asset(
                    Images.ic_visa, //TODO image var
                    height: 30,
                    width: 20,
                    color: PickColor.whiteColor,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 68,
                  child: Image.asset(
                    Images.ic_americanExpress, //TODO image var
                    height: 30,
                    width: 20,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 40,
                  child: Image.asset(
                   Images.ic_jsb2, //TODO image var
                    height: 30,
                    width: 20,
                  ),
                ),
                const Positioned(
                  left: 30,
                  bottom: 80,
                  child: Text(
                    "Your balance",
                    style: TextStyle(color: PickColor.whiteColor),
                  ),
                ),
                const Positioned(
                  left: 30,
                  bottom: 30,
                  child: Text(
                    "\$948.50",
                    style: TextStyle(color: PickColor.whiteColor, fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: PickColor.whiteColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TopupAmount()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.download_for_offline_outlined,
                          size: 15,
                          color: PickColor.blackColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Top Up",
                          style: TextStyle(color: PickColor.blackColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Transaction History Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transaction History",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TransactionHistory()),
                    );
                  },
                  child: const Text(
                    "View All  >",
                    style: TextStyle(color: PickColor.brownColor),
                  ),
                ),
              ],
            ),
            // Transaction List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10, bottom: 16),
                shrinkWrap: true,
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
                          Text(
                            "-\$ ${transaction['price']}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(transaction['date']),
                          Text(transaction['payMethod']),
                        ],
                      ),
                      const SizedBox(height: 10),

                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: PickColor.borderColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
