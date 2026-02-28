import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../my_ticket/view/cancelled_movie_list_screen.dart';
import '../my_ticket/view/past_movie_list_screen.dart';
import '../my_ticket/view/upcoming_movie_list_screen.dart';

class MyTicketFragment extends StatefulWidget {
  const MyTicketFragment({super.key});

  @override
  State<MyTicketFragment> createState() => _MyTicketFragmentState();
}

class _MyTicketFragmentState extends State<MyTicketFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("My Tickets", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
              30.height,
              Container(
                height: 45,
                padding: EdgeInsets.zero,
                width: context.width(),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    SizedBox(
                      width: 100,
                      child: Tab(text: "Upcoming"),
                    ),
                    SizedBox(
                      width: 100,
                      child: Tab(text: "Past"),
                    ),
                    SizedBox(
                      width: 100,
                      child: Tab(text: "Cancelled"),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16),
              Expanded(
                child: const TabBarView(
                  children: [
                    UpcomingMovieListScreen(),
                    PastMovieListScreen(),
                    CancelledMovieListScreen(),
                  ],
                ).paddingOnly(top: 16, left: 16, right: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
