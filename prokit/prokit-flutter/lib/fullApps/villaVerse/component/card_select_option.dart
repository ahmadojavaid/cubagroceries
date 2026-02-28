// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import 'filter_option.dart';

class CardSelectOption extends StatefulWidget {
  final List<dynamic> list;
  late int selectedIndex;
  final Color color;

  CardSelectOption({super.key, required this.list, required this.selectedIndex, required this.color});

  @override
  State<CardSelectOption> createState() => _CardSelectOptionState();
}

class _CardSelectOptionState extends State<CardSelectOption> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          final item = widget.list[index];
          return GestureDetector(
            onTap: () => setState(() {
              widget.selectedIndex = index;
            }),
            child: FilterOption(
              text: item['title'],
              backgroundColor: widget.selectedIndex == index ? primaryBlueColor : widget.color,
              textColor: widget.selectedIndex == index ? lightColor : primaryBlueColor,
              icon: item['icon'],
            ),
          ).paddingOnly(left: index == 0 ? 16 : 0, right: index == widget.list.length - 1 ? 16 : 0);
        },
      ),
    );
  }
}
