import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/wallet/screen/wallet_home_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class ChooseTopUpMethod extends StatelessWidget {
  const ChooseTopUpMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Top Up Method",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: PickColor.blackColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.greyColor),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(Images.img_paypalLogo, height: 50),
                        const SizedBox(width: 10),
                        const Text(
                          "PayPal",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          Images.img_googleLogo,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Google Pay",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          Images.img_applePayLogo,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Apple Pay",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: PickColor.brownColor), borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              Images.img_mastercardLogo,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        const Text(
                          PaymentMethodText.masterCardText,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.check,
                      color: PickColor.brownColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 70,
              width: 400,
              decoration: BoxDecoration(border: Border.all(color: PickColor.greyColor), borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          Images.img_visapay,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          PaymentMethodText.visaCardText,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  backgroundColor: PickColor.brownColor,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(
                                Images.img_lottie6,
                                height: 200,
                                reverse: true,
                                repeat: true,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Top Up Successful!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25, color: PickColor.brownColor, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 13),
                              const Text(
                                "The amount of \$100 has been added to your wallet",
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                                          backgroundColor: PickColor.brownColor,
                                        ),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(builder: (context) => const WalletHomeScreen()),
                                            (route) => false, // This removes all previous routes.
                                          );
                                        },
                                        child: const Text(
                                          "Ok",
                                          style: TextStyle(color: PickColor.whiteColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text(
                  "Confirm top Up - \$100.00",
                  style: TextStyle(color: PickColor.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
