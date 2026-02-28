import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';

Widget reviewItem(Map<String, dynamic> review) {
  return Card(
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(review['avatar']),
                radius: 25,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review['name'], style: TextStyle(fontSize: 15)),
                    4.height,
                    Text(review['date'], style: secondaryTextStyle(size: 12)),
                    8.height,
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: stayNestPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.yellow),
                    Text(
                      '${review['rating']}',
                      style: boldTextStyle(size: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(review['comment'], style: secondaryTextStyle(size: 14)),
        ],
      ),
    ),
  );
}
