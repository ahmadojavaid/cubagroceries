import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/driver_information/screen/paytip_to_driver_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../component/bottombarButton_component.dart';
import 'call_with_driver_screen.dart';

class RatingDriverScreen extends StatefulWidget {
  const RatingDriverScreen({super.key});

  @override
  State<RatingDriverScreen> createState() => _RatingDriverScreenState();
}

class _RatingDriverScreenState extends State<RatingDriverScreen> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.network(
                          Images.img_driver,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Let's rate your driver's delivery service",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "How was the delivery of your order from Caffely Astoria Aromas?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: PickColor.greyColor),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                Icons.star,
                                color: index < _selectedRating ? Colors.orange : Colors.grey,
                                size: 30,
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
                      const SizedBox(height: 25),
                      const Divider(color: PickColor.borderColor),
                      const SizedBox(height: 25),
                      const Text(
                        "Haven't received your order?",
                        style: TextStyle(color: PickColor.greyColor),
                      ),
                      const SizedBox(height: 25),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CallWithDriverScreen()),
                          );
                        },
                        child: const Text(
                          "Call your driver",
                          style: TextStyle(fontSize: 15, color: PickColor.brownColor, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: BottomBarButtonComponent(
              btnFirst: "Cancel",
              btnSecond: "Submit",
              btnSecondOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PayTipToDriverScreen(rating: _selectedRating),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
