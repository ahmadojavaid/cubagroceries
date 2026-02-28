import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../model/security_model.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

List<SecurityModel> securityDetailList = securityList();

class _SecurityScreenState extends State<SecurityScreen> {
  void _toggleSwitch(int index, bool value) {
    setState(() {
      securityDetailList[index].isActive = value; // Update the toggle state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Security",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: securityDetailList.length,
              itemBuilder: (context, index) {
                final notification = securityDetailList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: notification.isActive,
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
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Device Management",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, size: 20)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PickColor.brownColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Change Password",
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
  }
}
