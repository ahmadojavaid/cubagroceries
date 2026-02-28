import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../driver_information/screen/call_with_driver_screen.dart';
import '../../driver_information/screen/chat_with_driver_screen.dart';
import '../../driver_information/screen/driver_inforamation_screen.dart';

class DraggableScreen extends StatefulWidget {
  const DraggableScreen({super.key});

  @override
  State<DraggableScreen> createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {
  late String displayText = "Driver is heading to the coffee Shop";
  late final Timer? _timer;
  final DraggableScrollableController _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    // Set the timer to change text after 5 seconds
    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        displayText = "The driver is on his way to your location";
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      controller: _controller,
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.4,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: SingleChildScrollView(
              controller: scrollController,
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dragging handle
                      Center(
                        child: Container(
                          width: 100,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Text(displayText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Divider(color: PickColor.borderColor),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DriverInformationScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.network(
                                  Images.img_driver,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Rayford Chenail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                      Row(
                                        children: [
                                          Text("4.8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                          SizedBox(width: 10),
                                          Icon(Icons.star_half, color: PickColor.orange),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Yamaha MX King"),
                                      Text("HSW 4736 XK"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(color: PickColor.borderColor),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, left: 35, right: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: PickColor.redColor),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Text("X", style: TextStyle(fontSize: 20, color: PickColor.redColor)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChatWithDriverScreen()),
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: PickColor.brownColor),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.message_rounded,
                                  color: PickColor.brownColor,
                                  size: 20,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CallWithDriverScreen()),
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: PickColor.brownColor),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.call,
                                  color: PickColor.brownColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
