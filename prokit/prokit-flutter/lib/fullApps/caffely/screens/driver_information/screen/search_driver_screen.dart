import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../cancelorder/cancel_order_screen.dart';
import '../../googlemap/screen/drivermap_screen.dart';

class SearchDriverScreen extends StatefulWidget {
  const SearchDriverScreen({super.key});

  @override
  _SearchDriverScreenState createState() {
    return _SearchDriverScreenState();
  }
}

class _SearchDriverScreenState extends State<SearchDriverScreen> {
  bool showLoadingButton = true;
  bool showImage = false;

  @override
  void initState() {
    super.initState();
    _startLoadingSequence();
  }

  void _startLoadingSequence() async {
    // Show loading button for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      showLoadingButton = false;
      showImage = true;
    });

    // After 4 seconds, tap message will appear
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      showImage = true;
    });
  }

  void _navigateToOtherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GoogleMapScreen(), // Replace with your other screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          DriverInformationText.searchingDriver,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Map background
          Opacity(
            opacity: 0.3,
            child: Image.network(
              Images.img_map1,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white70, Colors.white10],
                  stops: [0, 0.5, 1],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Lottie.asset(
                  Images.img_lottieDriver,
                  height: showLoadingButton ? 86 : 100,
                  repeat: true,
                ),

                // Loader animation on top of the map
                if (showLoadingButton)
                  const Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        DriverInformationText.findingNearBy,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        DriverInformationText.mayTakeTime,
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          Positioned(
            child: Lottie.asset(
              Images.img_lottieLocationLoader,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              repeat: true,
            ),
          ),

          // Profile image with tap message
          if (showImage)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.39,
              child: GestureDetector(
                onTap: _navigateToOtherScreen,
                child: const Column(
                  children: [
                    Text(
                      "Tap here to track driver",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        Images.img_driver,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Slide to cancel button at the bottom
          Positioned(
            bottom: 30,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CancelOrderHomeScreen()),
                );
              },
              icon: const Icon(Icons.cancel, color: PickColor.redColor, size: 40),
              label: const Text(DriverInformationText.slideToCancle),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                foregroundColor: PickColor.blackColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
