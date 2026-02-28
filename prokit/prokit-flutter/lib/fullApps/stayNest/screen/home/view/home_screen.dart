import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/home/view/recently_booking.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/home/view/save_data_screen.dart';

import '../../../../../main.dart';
import '../../../components/app_custom_choice_chip.dart';
import '../../../components/hotel_card_component.dart';
import '../../../components/search_text_field.dart';
import '../../../store/hoteldata.dart';
import '../../../store/theme_store.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../component/home_components/horizontal_list_components.dart';
import 'notification_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final hotelStore = HotelStorecard();
  final themeStore = ThemeStore();

  final List<String> categories = [
    'All',
    'Popular',
    'Recommended',
    'Budget',
    'Luxury',
  ];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
          statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(Icons.flash_on, color: stayNestPrimaryColor, size: 28),
                Text(
                  'Helia',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: stayNestPrimaryColor,
                  ),
                  onPressed: () => NotificationsScreen().launch(context),
                ),
                IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    color: stayNestPrimaryColor,
                  ),
                  onPressed: () => SaveDataScreen().launch(context),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Jons 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).paddingSymmetric(horizontal: 16),
            16.height,
            SearchTextField(
              hintText: 'Search for hotels...',
              controller: _searchController,
              isDarkMode: appStore.isDarkModeOn,
            ),
            16.height,
            CategoryChips(
              categories: categories,
              selectedCategory: selectedCategory,
              isDarkMode: appStore.isDarkModeOn,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            20.height,
            HotelHorizontalList(hotelCard: hotelCard),
            24.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently Booked',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextButton(
                  onPressed: () => RecentlyBooking().launch(context),
                  child: Text(
                    'See All',
                    style: TextStyle(color: stayNestPrimaryColor),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            HomeRecently(),
          ],
        ),
      ),
    );
  }
}
