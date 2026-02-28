import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../movie/model/movie_model.dart';

class CancelledMovieListScreen extends StatefulWidget {
  const CancelledMovieListScreen({super.key});

  @override
  State<CancelledMovieListScreen> createState() => _CancelledMovieListScreenState();
}

class _CancelledMovieListScreenState extends State<CancelledMovieListScreen> {
  late List<AllMovie> allMovieData;

  @override
  void initState() {
    super.initState();
    allMovieData = getAllMovieList();
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
                AllMovie movieObj = allMovieData[index];

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
                              child: Image(image: NetworkImage(movieObj.image!), fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movieObj.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16),
                              ),
                              Text(
                                movieObj.subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: secondaryTextStyle(),
                              ).paddingOnly(top: 10),
                              Text(
                                movieObj.language!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ).paddingOnly(top: 10),
                            ],
                          ).paddingOnly(left: 16).expand(),
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
                      SizedBox(
                        width: context.width(),
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
