import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../model/notification.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  Map<String, List<NotificationItem>> _groupByDate(
    List<NotificationItem> items,
  ) {
    Map<String, List<NotificationItem>> grouped = {};
    for (var item in items) {
      grouped.putIfAbsent(item.dateGroup, () => []);
      grouped[item.dateGroup]!.add(item);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(notifications);

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: grouped.entries.expand((entry) {
          return [
            Text(entry.key, style: boldTextStyle(size: 16)),
            12.height,
            ...entry.value.map((item) {
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    if (item.icon != null)
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: stayNestPrimaryColor,
                        ),
                        child: Icon(item.icon, color: Colors.white),
                      )
                    else if (item.imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.imageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    12.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: boldTextStyle(size: 14)),
                          4.height,
                          Text(
                            item.subtitle,
                            style: secondaryTextStyle(size: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingAll(12),
              );
            }),
            20.height,
          ];
        }).toList(),
      ),
    );
  }
}
