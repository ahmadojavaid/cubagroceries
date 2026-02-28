import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/dashboard/streamit/component/banner_ad_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/btn_screen_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/channels_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/continue_watching_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/favourite_personality_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/genres_movies_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/head_banner_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/language_card_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/latest_movies_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/popular_movies_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/popular_videos_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/rate_the_app_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/top_10_component.dart';
import 'package:prokit_flutter/dashboard/streamit/component/tv_shows_component.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/app_colors.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/app_images.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/app_string.dart';

StreamITAppColors streamITAppColors = StreamITAppColors();
StreamITAppImages streamITAppImages = StreamITAppImages();
StreamITAppString streamITApString = StreamITAppString();

class StreamItHome extends StatefulWidget {
  const StreamItHome({super.key});

  @override
  State<StreamItHome> createState() => _StreamItHomeState();
}

class _StreamItHomeState extends State<StreamItHome> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
  value: const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ),
      child: Scaffold(
        backgroundColor: streamITAppColors.black,
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: streamITAppColors.black,
          selectedItemColor: streamITAppColors.white,
          unselectedItemColor: streamITAppColors.grey,
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Coming Soon',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live TV'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadBanner(),
                  const ContinueWatchingSection(),
                  const Top10MoviesSection(),
                  const AdImages(),
                  const LatestMovies(),
                  LanguageCard(),
                  const PopularMovies(),
                  Channels(),
                  const FavouritePersonality(),
                  const GenresMovies(),
                  const PopularVideos(),
                  const PopularTVCategory(),
                  RateTheApp(),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(child: FilterDropdown()),
            ),
          ],
        ),
      ),
    );
  }
}
