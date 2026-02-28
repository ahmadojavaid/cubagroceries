import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class VideoWithDriverScreen extends StatelessWidget {
  const VideoWithDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
          Images.img_driver,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        ),
        Positioned(
          bottom: 100,
          right: 20,
          child: Container(
            width: 110,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                Images.img_user,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 110,
          right: 30,
          child: Icon(Icons.cameraswitch_sharp, color: PickColor.whiteColor),
        ),

        // Buttons positioned at the bottom
        Positioned(
          bottom: 30,
          left: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 190, 60, 50),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Image.asset(Images.ic_callldisconnect, color: PickColor.whiteColor),
                ),
              ),
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: PickColor.whiteColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Icon(Icons.video_call_outlined, color: PickColor.whiteColor),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: PickColor.whiteColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Icon(Icons.volume_up, color: PickColor.whiteColor),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: PickColor.whiteColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Icon(Icons.mic, color: PickColor.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
