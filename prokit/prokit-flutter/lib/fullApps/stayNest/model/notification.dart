// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../utils/images.dart';

class NotificationItem {
  final IconData? icon;
  final String? imageUrl;
  final String title;
  final String subtitle;
  final String dateGroup;

  NotificationItem({
    this.icon,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.dateGroup,
  });
}

List<NotificationItem> Notifications() {
  List<NotificationItem> notifications = [];
  notifications.add(
    NotificationItem(
      icon: Icons.chat_bubble_outline,
      title: "You have 4 new message",
      subtitle: "Jayant agent shared a message",
      dateGroup: "Today",
    ),
  );
  notifications.add(
    NotificationItem(
      imageUrl: userImage,
      title: 'You Saved “Malon Greens”',
      subtitle: 'You just bookmarked',
      dateGroup: "Today",
    ),
  );

  notifications.add(
    NotificationItem(
      icon: Icons.local_offer_outlined,
      title: 'Get 30% Off on first booking',
      subtitle: 'Special promotion only valid today',
      dateGroup: "Yesterday",
    ),
  );

  notifications.add(
    NotificationItem(
      icon: Icons.lock_outline,
      title: 'Password Update Successful',
      subtitle: 'Your password was updated successfully',
      dateGroup: "Yesterday",
    ),
  );

  notifications.add(
    NotificationItem(
      imageUrl: userImage,
      title: 'You Saved “Peradise Mint”',
      subtitle: 'You just bookmarked',
      dateGroup: "Yesterday",
    ),
  );

  return notifications;
}
