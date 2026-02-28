import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class NotificationAccountScreen extends StatefulWidget {
  const NotificationAccountScreen({super.key});

  @override
  State<NotificationAccountScreen> createState() => _NotificationAccountScreenState();
}

final List<Map<String, dynamic>> notificationList = [
  {
    "name": "Order Updates",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "Exclusive Offer",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "New Coffee Releases",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "Nearby Shop Alerts",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "Reminder for Favorite Orders",
    "icon": const Icon(Icons.toggle_off_outlined),
    "isActive": false,
  },
  {
    "name": "Low Balance in Wallet",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "Upcoming Events",
    "icon": const Icon(Icons.toggle_off_outlined),
    "isActive": false,
  },
  {
    "name": "Weather-Based Suggestions",
    "icon": const Icon(Icons.toggle_off_outlined),
    "isActive": false,
  },
  {
    "name": "Rate and Review Requests",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "Referral Rewards",
    "icon": const Icon(Icons.toggle_off_outlined),
    "isActive": false,
  },
  {
    "name": "Refunds and Cancellations",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "Coffee Tips and Fun Facts",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
  {
    "name": "App Updates",
    "icon": const Icon(Icons.toggle_on),
    "isActive": true,
  },
];

class _NotificationAccountScreenState extends State<NotificationAccountScreen> {
  void _toggleSwitch(int index, bool value) {
    setState(() {
      notificationList[index]["isActive"] = value; // Update the toggle state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            final notification = notificationList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notification["name"],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  // Wrap Switch in Transform.scale to change its size
                  Transform.scale(
                    scale: 0.6, // Adjust this value to change the size (1.5 means 150% of the original size)
                    child: Switch(
                      value: notification["isActive"],
                      onChanged: (value) => _toggleSwitch(index, value),
                      activeTrackColor: PickColor.brownColor,
                      activeColor: PickColor.whiteColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
