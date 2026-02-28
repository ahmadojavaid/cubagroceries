import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/driver_information/screen/rating_driver_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../component/bottombarButton_component.dart';

class WhatsYourMoodScreen extends StatefulWidget {
  const WhatsYourMoodScreen({super.key});

  @override
  State<WhatsYourMoodScreen> createState() => _WhatsYourMoodScreenState();
}

class _WhatsYourMoodScreenState extends State<WhatsYourMoodScreen> {
  int selectedMoodIndex = 0;

  final List<String> moodList = [
    Images.img_emoji1,
    Images.img_emoji2,
    Images.img_emoji3,
    Images.img_emoji4,
    Images.img_emoji5,
    Images.img_emoji6,
    Images.img_emoji7,
    Images.img_emoji8,
    Images.img_emoji9,
    Images.img_emoji10,
    Images.img_emoji11,
    Images.img_emoji12,
    Images.img_emoji13,
    Images.img_emoji14,
    Images.img_emoji15,
    Images.img_emoji16,
    Images.img_emoji17,
    Images.img_emoji18,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const Text("What's Your Mood!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("about this order?", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: moodList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 items per row
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final moodImagePath = moodList[index];
                      final isSelected = selectedMoodIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMoodIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelected ? Border.all(color: PickColor.brownColor, width: 2) : null,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.network(moodImagePath, height: 80, width: 60),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: BottomBarButtonComponent(
            btnFirst: "Cancle",
            btnSecond: "Submit",
            btnSecondOnTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RatingDriverScreen())),
            },
          ),
        )
      ]),
    );
  }
}
