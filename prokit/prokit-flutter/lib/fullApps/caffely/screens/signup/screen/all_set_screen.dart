import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../home/screen/home_page_screen.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  Images.img_lottie6, //TODO: lottie var
                  height: 200,
                  reverse: true,
                  repeat: true,
                ),
                const Text(SigInUpText.allSet, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text(SigInUpText.advantureBegins, style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: BottomButton(
            btnText: "Start Exploring",
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageScreen())),
            },
          ),
        )
      ]),
    );
  }
}
