import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/common.dart';


class Channels extends StatelessWidget {
  Channels({super.key});

  final List<String> imagePaths = [
    streamITAppImages.channel1,
    streamITAppImages.channel2,
    streamITAppImages.channel3,
    streamITAppImages.channel4,
    streamITAppImages.channel5,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          titleRowWidget(streamITApString.topChannels),
          SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: streamITAppColors.fadeBlack,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: streamITAppColors.white10, width: 0.6),
                  ),
                  child: Image.network(
                    imagePaths[index],
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
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
