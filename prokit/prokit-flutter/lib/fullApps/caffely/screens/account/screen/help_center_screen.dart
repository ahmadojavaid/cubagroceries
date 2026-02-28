import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../model/help_center_model.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

final List<String> helpList = ["General", "Account", "Orders", "Coffee", "Shop", "Payment"];

List<HelpCenterModel> helpCenterListData = helpCenterList();

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int selectedIndex = 0;
  List<bool> isExpandedList = List.filled(helpCenterList().length, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: helpList.length,
                itemBuilder: (context, index) {
                  final help = helpList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      width: 100,
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? PickColor.brownColor : Colors.transparent,
                        border: Border.all(color: PickColor.borderColor),
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Center(
                        child: Text(
                          help,
                          style: TextStyle(
                            color: selectedIndex == index ? PickColor.whiteColor : PickColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                fillColor: PickColor.borderColor,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                isDense: true,
                hintText: "Search",
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: helpCenterListData.length,
                itemBuilder: (context, index) {
                  final question = helpCenterListData[index];
                  final isExpanded = isExpandedList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: PickColor.borderColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                question.question,
                                maxLines: 2,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              IconButton(
                                icon: Icon(
                                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isExpandedList[index] = !isExpanded;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (isExpanded)
                            Column(
                              children: [
                                const Divider(color: PickColor.borderColor),
                                Text(
                                  question.description,
                                  style: const TextStyle(height: 1.5),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
