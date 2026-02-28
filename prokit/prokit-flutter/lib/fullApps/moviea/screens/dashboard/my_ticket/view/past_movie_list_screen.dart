import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../review/add_review_screen.dart';
import '../../movie/latest_movie/model/latest_movie_model.dart';

class PastMovieListScreen extends StatefulWidget {
  const PastMovieListScreen({super.key});

  @override
  State<PastMovieListScreen> createState() => _PastMovieListScreenState();
}

class _PastMovieListScreenState extends State<PastMovieListScreen> {
  late List<LatestMovie> allMovieData;

  @override
  void initState() {
    super.initState();
    allMovieData = getLatestMovieList();
  }

  void _openIconButtonPressed(LatestMovie movie) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.height() * 0.65,
          child: AddReviewScreen(
            image: movie.image!,
            title: movie.title!,
            subtitle: movie.subtitle!,
            description: movie.description!,
            types: movie.type!,
            duration: movie.duration!,
            rating: movie.rating!,
          ),
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
                LatestMovie movieData = allMovieData[index];

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
                              child: Image(
                                image: NetworkImage(movieData.image!), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
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
                                style: secondaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).paddingOnly(top: 10),
                              Text(
                                movieData.language!,
                                style: const TextStyle(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).paddingOnly(top: 10),
                            ],
                          ).expand(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: boxDecorationDefault(
                              color: Colors.grey.shade100,
                              boxShadow: [const BoxShadow(color: Colors.transparent)]
                            ),
                            child: const Text("Paid"),
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
                              onTap: () async {},
                              child: Text("View Details", style: boldTextStyle(color: Colors.black)),
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
                              onTap: () {
                                _openIconButtonPressed(movieData);
                              },
                              child: Text("Write a Review", style: boldTextStyle(color: Colors.white)),
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
