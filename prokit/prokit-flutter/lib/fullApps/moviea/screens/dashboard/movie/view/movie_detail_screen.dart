import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/moviea/screens/dashboard/movie/view/select_seat_screen.dart';

class AllMovieDetailScreen extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String types;
  final String duration;
  final String rating;

  const AllMovieDetailScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.types,
    required this.duration,
    required this.rating,
  });

  @override
  State<AllMovieDetailScreen> createState() => _AllMovieDetailScreenState();
}

class _AllMovieDetailScreenState extends State<AllMovieDetailScreen> {
  late String _receivedImage;
  late String _receivedTitle;
  late String _receivedSubtitle;
  late String _receivedDescription;
  late String _receivedTypes;
  late String _receivedDuration;
  late String _receivedRating;

  @override
  void initState() {
    super.initState();
    _receivedImage = widget.image;
    _receivedTitle = widget.title;
    _receivedSubtitle = widget.subtitle;
    _receivedDescription = widget.description;
    _receivedTypes = widget.types;
    _receivedDuration = widget.duration;
    _receivedRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: Text("Movie Details", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(_receivedImage),
                      height: 250,
                      width: 210,
                      fit: BoxFit.cover,
                    ),
                  ).expand(flex: 3),
                  16.width,
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 90,
                        decoration: boxDecorationDefault(
                          color: context.cardColor,
                          borderRadius: radius(10),
                          boxShadow: [const BoxShadow(color: Colors.transparent)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_camera_back_outlined,
                              color: Colors.red,
                            ).paddingOnly(top: 5),
                            const Text(
                              "Type",
                              style: TextStyle(color: Colors.black38),
                            ),
                            Text(
                              _receivedTypes,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      Container(
                        height: 70,
                        width: 90,
                        decoration: boxDecorationDefault(
                          color: context.cardColor,
                          borderRadius: radius(10),
                          boxShadow: [const BoxShadow(color: Colors.transparent)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.red,
                            ).paddingOnly(top: 5),
                            const Text(
                              "Duration",
                              style: TextStyle(color: Colors.black38),
                            ),
                            Text(
                              _receivedDuration,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      Container(
                        height: 70,
                        width: 90,
                        decoration: boxDecorationDefault(
                          color: context.cardColor,
                          borderRadius: radius(10),
                          boxShadow: [const BoxShadow(color: Colors.transparent)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_border,
                              color: Colors.red,
                            ).paddingOnly(top: 5),
                            const Text(
                              "Rating",
                              style: TextStyle(color: Colors.black38),
                            ),
                            Text(
                              _receivedRating,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).expand()
                ],
              ),
              Text(
                _receivedTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ).paddingOnly(top: 16),
              Text(
                _receivedSubtitle,
                style: const TextStyle(fontSize: 16, color: Colors.black38),
              ).paddingOnly(top: 5),
              const Text(
                "Descriptions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ).paddingOnly(top: 16),
              Text(_receivedDescription, textAlign: TextAlign.start, style: const TextStyle(fontSize: 18)).paddingOnly(top: 10),
            ],
          ).paddingAll(16),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: AppButton(
            elevation: 0,
            width: context.width(),
            color: Colors.red,
            shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            onTap: () {
              SelectSeatScreen(
                image: widget.image,
                title: widget.title,
                subtitle: widget.subtitle,
                description: widget.description,
                types: widget.types,
                duration: widget.duration,
                rating: widget.rating,
              ).launch(context);
            },
            child: Text("Select seat", style: boldTextStyle(color: white)),
          ),
        ),
      ]),
    );
  }
}
