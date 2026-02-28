import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../home/screen/home_page_screen.dart';

class CancelBottomSheetComponent extends StatelessWidget {
  const CancelBottomSheetComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              backgroundColor: PickColor.brownColor,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: SizedBox(
                      height: 270,
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Cancel Order",
                            style: TextStyle(
                              fontSize: 20,
                              color: PickColor.callDisconect,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: PickColor.borderColor),
                          const SizedBox(height: 10),
                          const Text(
                            "Are you sure you want to cancel the order?",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          const Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: 'Only 90% of funds will be returned to your account based on our ',
                              children: [
                                TextSpan(
                                  text: 'terms and conditions',
                                  style: TextStyle(color: PickColor.brownColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      backgroundColor: PickColor.borderColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "No, Don't Cancel",
                                      style: TextStyle(color: PickColor.brownColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      backgroundColor: PickColor.brownColor,
                                    ),
                                    child: const Text("Yes, Cancel", style: TextStyle(color: PickColor.whiteColor)),
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
                                                    "Order Successfully Cancelled",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      color: PickColor.brownColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 13),
                                                  const Text(
                                                    "90% of the funds have been returned to your account.",
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
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => const HomePageScreen(),
                                                                ),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text(
              "Cancel Order",
              style: TextStyle(color: PickColor.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
