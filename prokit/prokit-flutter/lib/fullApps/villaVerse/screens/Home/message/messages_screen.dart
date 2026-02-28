import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import 'messageComponents/call_list.dart';
import '../../../../../main.dart';
import 'messageComponents/chat_list.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
        elevation: 0,
        scrolledUnderElevation: 00,
        titleSpacing: 0,
        title: ListTile(
          leading: Image.asset(
            villaVerse,
            height: 40,
            width: 40,
          ),
          title: Text(
            "Messages",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                size: 25,
                color: appStore.isDarkModeOn ? lightColor : darkColor,
              ),
              12.width,
            ],
          ),
        ),
        bottom: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: primaryBlueColor, strokeAlign: 50),
            insets: EdgeInsets.symmetric(horizontal: 100),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          labelColor: primaryBlueColor,
          unselectedLabelColor:  appStore.isDarkModeOn ? lightColor : darkColor,
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChatList(),
          CallList(),
        ],
      ),
    );
  }
}