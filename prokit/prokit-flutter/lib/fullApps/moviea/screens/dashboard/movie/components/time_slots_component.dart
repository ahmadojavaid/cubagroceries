import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TimeSlotsComponent extends StatefulWidget {
  const TimeSlotsComponent({super.key});

  @override
  State<TimeSlotsComponent> createState() => _TimeSlotsComponentState();
}

class _TimeSlotsComponentState extends State<TimeSlotsComponent> {
  String selectedTab = ''; // Track the selected tab

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildTab("9:00"),
          buildTab("9:15"),
          buildTab("9:30"),
          buildTab("9:45"),
          buildTab("10:00"),
          buildTab("10:15"),
          buildTab("10:30"),
          buildTab("10:45"),
          buildTab("11:00"),
          buildTab("11:15"),
          buildTab("11:30"),
          buildTab("11:45"),
          buildTab("12:00"),
          buildTab("3:00"),
          buildTab("3:15"),
          buildTab("3:30"),
          buildTab("3:45"),
          buildTab("4:00"),
          buildTab("4:15"),
          buildTab("4:30"),
          buildTab("4:45"),
          buildTab("5:00"),
          buildTab("5:15"),
          buildTab("5:30"),
          buildTab("5:45"),
          buildTab("6:00"),
        ],
      ),
    );
  }

  Widget buildTab(String tabName) {
    bool isSelected = selectedTab == tabName;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = tabName;
          });
          log("$tabName tap");
        },
        child: Container(
          height: 45,
          width: 90,
          decoration: BoxDecoration(
            color: isSelected ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(tabName, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
          ),
        ).paddingOnly(left: 4, right: 4),
      ),
    );
  }
}
