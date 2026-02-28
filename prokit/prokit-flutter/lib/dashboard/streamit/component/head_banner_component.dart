import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/streamit/model/screeen_model.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';

class HeadBanner extends StatefulWidget {
  const HeadBanner({super.key});

  @override
  State<HeadBanner> createState() => _HeadBannerState();
}

class _HeadBannerState extends State<HeadBanner> {
  late final PageController _pageController;
  int _currentPage = 1;
  Timer? _autoScrollTimer;
  List<MainPageView> get _loopedMovies {
    final movies = dummyMovies;
    return [
      movies.last,
      ...movies,
      movies.first,
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(viewportFraction: 1.0, initialPage: _currentPage);
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      int nextPage = _currentPage + 1;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _loopedMovies.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (index == 0) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  _pageController.jumpToPage(_loopedMovies.length - 2);
                });
              } else if (index == _loopedMovies.length - 1) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  _pageController.jumpToPage(1);
                });
              }
            },
            itemBuilder: (context, index) {
              final movie = _loopedMovies[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.movieImage,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          streamITAppColors.black
                              .withAlpha((0.7 * 255).toInt()),
                          streamITAppColors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 358,
                    left: 58.05,
                    right: 58.05,
                    child: SizedBox(
                      height: 181,
                      width: 311.91,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(movie.movieName, style: movieTitle()),
                          ),
                          SizedBox(
                            height: 30,
                            width: 311.91,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Marquee(
                                direction: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(movie.releaseYear,
                                        style: movieDiscription()),
                                    SizedBox(width: 16),
                                    movieDetailsRow(Icons.translate_rounded,
                                        movie.language),
                                    SizedBox(width: 16),
                                    movieDetailsRow(Icons.access_time_outlined,
                                        movie.movieDuration),
                                    SizedBox(width: 16),
                                    starRatingRow(
                                        Icons.star, "${movie.rating} (IMDB)"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                streamITAppImages.addCircle,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: streamITAppColors.btnColor,
                                  foregroundColor: streamITAppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: const Icon(Icons.play_arrow),
                                label: Text(streamITApString.playNOw),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  dummyMovies.length,
                  (index) {
                    int realIndex = _currentPage - 1;
                    if (realIndex < 0) realIndex = dummyMovies.length - 1;
                    if (realIndex >= dummyMovies.length) realIndex = 0;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: realIndex == index ? 12 : 6,
                      height: realIndex == index ? 12 : 6,
                      decoration: BoxDecoration(
                        color: realIndex == index
                            ? streamITAppColors.white
                            : streamITAppColors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.2,
                    child: Image.network(
                      streamITAppImages.streamITLogo,
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: streamITAppColors.subYellow, width: 0.8),
                        color: streamITAppColors.subBG,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6),
                          child: Text(
                            "SUBSCRIBE",
                            style: GoogleFonts.roboto(
                              color: streamITAppColors.subYellow,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.cast, color: streamITAppColors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle movieTitle() {
  return GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 22,
    color: streamITAppColors.white,
  );
}

TextStyle movieDiscription() {
  return GoogleFonts.roboto(
    color: streamITAppColors.movieDis,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.83,
  );
}

Widget movieDetailsRow(IconData icon, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: streamITAppColors.movieDis, size: 14),
      SizedBox(width: 4),
      Text(label, style: movieDiscription()),
    ],
  );
}

Widget starRatingRow(IconData icon, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: streamITAppColors.avatarBG, size: 14),
      SizedBox(width: 4),
      Text(label, style: movieDiscription()),
    ],
  );
}
