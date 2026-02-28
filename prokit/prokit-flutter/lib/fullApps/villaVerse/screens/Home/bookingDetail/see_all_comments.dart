import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../component/card_select_option.dart';
import '../../../component/my_app_bar.dart';
import '../../../models/rating_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class SeeAllComments extends StatefulWidget {
  const SeeAllComments({super.key});

  @override
  State<SeeAllComments> createState() => _SeeAllCommentsState();
}

class _SeeAllCommentsState extends State<SeeAllComments> {
  int selectedIndex = 0;
  List<dynamic> rating = [
    {'title': 'All', 'icon': Icons.star},
    {'title': '5', 'icon': Icons.star},
    {'title': '4', 'icon': Icons.star},
    {'title': '3', 'icon': Icons.star},
    {'title': '2', 'icon': Icons.star},
    {'title': '1', 'icon': Icons.star},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: '4.8 (1,275 reviews)'),
      body: Column(
        children: [
          16.height,
          CardSelectOption(
            list: rating,
            selectedIndex: selectedIndex,
            color: appStore.isDarkModeOn ? darkColor : lightColor,
          ),
          20.height,
          Expanded(
            child: AnimatedListView(
              itemCount: ratingList.length,
              itemBuilder: (context, index) {
                return showRating(ratingList[index]).paddingOnly(
                    top: 16, bottom: index == ratingList.length - 1 ? 30 : 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget showRating(RatingModel rating) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(rating.imageUrl), // Replace this
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  rating.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryBlueColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 16, color: primaryBlueColor),
                    SizedBox(width: 4),
                    Text(rating.rating.toString(),
                        style: TextStyle(color: primaryBlueColor)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),

          const SizedBox(height: 12),

          // Review Text
          Text(
            rating.comment,
            style: TextStyle(fontSize: 15),
          ),

          const SizedBox(height: 16),

          // Bottom Row
          Row(
            children: [
              const Icon(Icons.favorite, color: primaryBlueColor, size: 20),
              const SizedBox(width: 4),
              const Text('938'),
              const Spacer(),
              Text(
                rating.time.timeAgo,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 16);
  }
}
