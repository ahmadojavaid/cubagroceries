import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../home/screen/home_page_screen.dart';

class ThanksForFeedbackScreen extends StatelessWidget {
  const ThanksForFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                  color: PickColor.brownColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 50),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Thank you for your feedback!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "See you on the next order!",
                style: TextStyle(fontSize: 15, color: PickColor.greyColor),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: BottomButton(
            btnText: "Ok",
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageScreen())),
            },
          ),
        )
      ]),
    );
  }
}
