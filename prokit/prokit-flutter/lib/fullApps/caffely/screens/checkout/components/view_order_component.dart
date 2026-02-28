import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../home/screen/home_page_screen.dart';

class ViewOrderComponent extends StatelessWidget {
  const ViewOrderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                backgroundColor: PickColor.brownColor,
              ),
              child: const Text(
                DeliveryDetailText.placeOrder,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(20.0),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(
                            Images.img_lottie4,
                            height: 200,
                            reverse: true,
                            repeat: true,
                          ),
                          const SizedBox(height: 16),
                          const Text(DeliveryDetailText.orderSuccess, style: TextStyle(fontSize: 30)),
                          const SizedBox(height: 13),
                          const Text(DeliveryDetailText.orderSuccessQuotes),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    backgroundColor: PickColor.brownColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    DeliveryDetailText.viewMyOrder,
                                    style: TextStyle(color: PickColor.whiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
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
                                      MaterialPageRoute(builder: (context) => const HomePageScreen()),
                                    );
                                  },
                                  child: const Text(
                                    DeliveryDetailText.backToHome,
                                    style: TextStyle(color: PickColor.whiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
