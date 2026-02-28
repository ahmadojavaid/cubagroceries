import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../movie/favourite_movie/model/favourite_movie_model.dart';
import '../../movie/view/view_ticket_screen.dart';
import '../components/cancel_booking_component.dart';

class UpcomingMovieListScreen extends StatefulWidget {
  const UpcomingMovieListScreen({super.key});

  @override
  State<UpcomingMovieListScreen> createState() => _UpcomingMovieListScreenState();
}

class _UpcomingMovieListScreenState extends State<UpcomingMovieListScreen> {
  late List<FavouriteMovie> allMovieData;

  @override
  void initState() {
    super.initState();
    allMovieData = getFavourItemMovieList();
  }

  void _openIconButtonPressed(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.height() * 0.65,
          child: const CancelBookingComponent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allMovieData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                FavouriteMovie movieData = allMovieData[index];

                return Container(
                  decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(image: NetworkImage(movieData.image!), fit: BoxFit.cover),
                            ),
                          ),
                          16.width,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movieData.title!,
                                style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                movieData.subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: secondaryTextStyle(),
                              ).paddingOnly(top: 10),
                              Text(
                                movieData.language!,
                                style: primaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).paddingOnly(top: 10),
                            ],
                          ).expand(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                            child: const Text("Paid", style: TextStyle(color: Colors.red)),
                          ).paddingOnly(right: 10, left: 16),
                        ],
                      ),
                      16.height,
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              elevation: 0,
                              color: Colors.white,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              onTap: () {
                                _openIconButtonPressed(context);
                              },
                              child: Text("Cancel Booking", style: boldTextStyle(color: Colors.black)),
                            ),
                          ),
                          16.width,
                          Expanded(
                            child: AppButton(
                              elevation: 0,
                              color: Colors.red,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(color: Colors.red),
                              ),
                              onTap: () async {
                                const ViewTicketScreen().launch(context);
                              },
                              child: Text("View Ticket", style: boldTextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ).paddingAll(16),
                ).paddingOnly(top: 16);
              },
            ),
          ],
        ),
      ),
    );
  }
}
