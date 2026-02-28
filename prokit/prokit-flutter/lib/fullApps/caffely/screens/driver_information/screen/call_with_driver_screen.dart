import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class CallWithDriverScreen extends StatelessWidget {
  const CallWithDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [PickColor.gradientBlue, PickColor.gradientPink, PickColor.gradientOrange],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ClipOval(
                  child: Image.network(
                    Images.img_driver,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  DriverInformationText.driverName,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: PickColor.whiteColor,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(DriverInformationText.callDuration, style: TextStyle(color: PickColor.whiteColor))
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50), // To match circular shape
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: PickColor.callDisconect.withOpacity(0.3), // Adjust opacity

                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Image.asset(
                        Images.ic_callldisconnect,
                        color: PickColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // Blurred background icon 2
                ClipRRect(
                  borderRadius: BorderRadius.circular(50), // To match circular shape
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: PickColor.whiteColor.withOpacity(0.3), // Adjust opacity

                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Icon(
                        Icons.volume_up,
                        color: PickColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50), // To match circular shape
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: PickColor.whiteColor.withOpacity(0.3), // Adjust opacity
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Icon(
                        Icons.mic,
                        color: PickColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
