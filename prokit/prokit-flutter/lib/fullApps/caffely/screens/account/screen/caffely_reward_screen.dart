import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/images.dart';

class CaffelyRewardScreen extends StatelessWidget {
  const CaffelyRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caffely Rewards', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.info_outline, color: PickColor.blackColor),
          )
        ],
      ),
      body: Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Get Free Coffee!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                const Text(
                  'Get a free coffee discount voucher every time your friend joins via your referal code',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: PickColor.greyColor),
                ),
                const SizedBox(height: 15),
                Image.network(
                  Images.img_qrCode,
                  height: 390,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text("Copy or share the referral code below:", style: TextStyle(fontSize: 15, color: PickColor.greyColor)),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: PickColor.borderColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("E9RC5G", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        Icon(Icons.copy, size: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          left: 16.0,
          child: BottomButton(btnText: "Ok", onTap: () => Navigator.pop(context)),
        )
      ]),
    );
  }
}
