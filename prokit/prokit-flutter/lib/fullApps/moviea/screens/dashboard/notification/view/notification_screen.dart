import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationModel> todayList;
  late List<NotificationModel> yesterdayList;

  @override
  void initState() {
    super.initState();

    todayList = getTodayList();
    yesterdayList = getyestrdayList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            finish(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text("Notification", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today", style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)).paddingOnly(top: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: todayList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NotificationModel movieobj = todayList[index];

                return Container(
                  decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                                child: Image(
                                  image: NetworkImage(movieobj.icon!),
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movieobj.title!, style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)),
                              6.height,
                              Text(movieobj.subtitle!, style: const TextStyle(color: Colors.grey)),
                            ],
                          ).paddingOnly(left: 16),
                        ],
                      ),
                    ],
                  ),
                ).paddingOnly(top: 16);
              },
            ),
            16.height,
            Text("Yesterday", style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)).paddingOnly(top: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: yesterdayList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NotificationModel movieobj = yesterdayList[index];

                return Container(
                  decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcATop,
                                ),
                                child: Image(
                                  image: NetworkImage(movieobj.icon!),
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movieobj.title!, style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)),
                              6.height,
                              Text(
                                movieobj.subtitle!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ).paddingOnly(left: 16),
                        ],
                      ),
                    ],
                  ),
                ).paddingOnly(top: 16);
              },
            ),
          ],
        ).paddingOnly(left: 16, right: 16, bottom: 16),
      ),
    );
  }
}
