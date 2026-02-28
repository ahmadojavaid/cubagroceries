import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class NotificationTile extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const NotificationTile({
    super.key,
    this.icon,
    this.imagePath,
    required this.title,
    required this.subtitle,
    this.backgroundColor = const Color(0xFFEEF1FF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: stayNestPrimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(imagePath!, width: 40, height: 40, fit: BoxFit.cover),
                  )
                : Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
