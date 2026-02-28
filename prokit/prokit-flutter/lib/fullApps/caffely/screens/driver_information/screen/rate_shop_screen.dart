import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/driver_information/screen/thanks_for_feedback_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../component/bottombarButton_component.dart';

class RateShopScreen extends StatefulWidget {
  const RateShopScreen({super.key});

  @override
  State<RateShopScreen> createState() => _RateShopScreenState();
}

class _RateShopScreenState extends State<RateShopScreen> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Image.network(Images.img_cafe11, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Enjoyed your coffee?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Rate the shop, your feedback is matters.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: PickColor.greyColor),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              Icons.star,
                              color: index < _selectedRating ? Colors.orange : Colors.grey,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedRating = index + 1;
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: PickColor.borderColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Leave your review",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Amazing coffee shop with a variety of option. I enjoyed the 'Classic Brew' 🥰",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          left: 16.0,
          child: BottomBarButtonComponent(
            btnFirst: "Cancel",
            btnSecond: "Submit",
            btnSecondOnTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThanksForFeedbackScreen()),
              ),
            },
          ),
        )
      ]),
    );
  }
}
