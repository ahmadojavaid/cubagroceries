import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/driver_information/screen/whatsyour_mood_screen.dart';

import '../../../utils/comman.dart';
import '../../../utils/images.dart';

class EarnRewardCelebrationScreen extends StatelessWidget {
  const EarnRewardCelebrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(Images.img_celebration),
                const SizedBox(height: 10),
                const Text(
                  "Congratulations!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You earn 25 points from this order. You can see the pointson the Caffely Points menu",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: BottomButton(
            btnText: "Ok",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const WhatsYourMoodScreen()));
            },
          ),
        )
      ]),
    );
  }
}
