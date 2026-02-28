import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import '../../../../../main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<dynamic> _notificationList = [
    {
      "title": "Booking Successful!",
      "date": "20 Dec, 2022",
      "time": "20:49 PM",
      "description": "Congratulations! You have successfully booked a houses for 3 days for \$90. Enjoy the services!",
      "status": "New",
    },
    {
      "title": "Booking Successful!",
      "date": "19 Dec, 2022",
      "time": "18:35 PM",
      "description": "Congratulations! You have successfully booked a villa for 5 days for \$150. Enjoy the services!",
      "status": "New",
    },
    {
      "title": "New Services Available!",
      "date": "14 Dec, 2022",
      "time": "10:52 AM",
      "description": "You can now make multiple book real estate at once. You can also cancel your booking.",
      "status": "",
    },
    {
      "title": "Credit Card Connected!",
      "date": "12 Dec, 2022",
      "time": "15:38 PM",
      "description": "Your credit card has been successfully linked with Reosa. Enjoy our service.",
      "status": "",
    },
    {
      "title": "Account Setup Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "description": "Your account creation is successful, you can now experience our services.",
      "status": "",
    },
    {
      "title": "Account Setup Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "description": "Your account creation is successful, you can now experience our services.",
      "status": "",
    },
    {
      "title": "Account Setup Successful!",
      "date": "12 Dec, 2022",
      "time": "14:27 PM",
      "description": "Your account creation is successful, you can now experience our services.",
      "status": "",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        scrolledUnderElevation: 00,
        elevation: 00,
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
        title: Text(
          "Notification",
        ),
        leading: GestureDetector(
          onTap: () => finish(context),
          child: Icon(Icons.arrow_back, color: appStore.isDarkModeOn ? lightColor : darkColor),
        ),
      ),
      body: AnimatedListView(
        itemCount: _notificationList.length,
        emptyWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                notification,
                height: 200,
                width: 200,
              ),
              16.height,
              Text(
                "Empty",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "You don't have any notification at this time",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        itemBuilder: (context, index) {
          final item = _notificationList[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications, color: primaryBlueColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (item['status'] == "New")
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryBlueColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "New",
                          style: TextStyle(
                            color: lightColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "${item['date']}  |  ${item['time']}",
                  style: TextStyle(color: hintTextColor, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  item['description']!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ).paddingOnly(top: index == 0 ? 16 : 8, bottom: index == _notificationList.length - 1 ? 50 : 0, left: 16, right: 16);
        },
      ),
    );
  }
}