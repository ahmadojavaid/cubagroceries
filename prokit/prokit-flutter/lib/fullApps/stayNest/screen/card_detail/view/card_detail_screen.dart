// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/card_detail/view/review_screen.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/card_detail/view/select_date_screen.dart';

import '../../../../../main.dart';
import '../../../store/hoteldata.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../components/detail_card_component/button_custom.dart';
import '../components/detail_card_component/detail_icon.dart';
import '../components/detail_card_component/gallery_component.dart';
import '../components/detail_card_component/review_component.dart';
import 'location_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final int hotelId;

  const HotelDetailScreen({super.key, required this.hotelId});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  final PageController _pageController = PageController();
  final HotelStorecard hotelStorecard = HotelStorecard();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool save = false;

  void savedata() {
    setState(() {
      save = !save;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkModeOn == true ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      body: SizedBox.expand(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Observer(
                  builder: (context) {
                    final hotel = hotelCard[widget.hotelId];

                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                30.height,
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: PageView.builder(
                                        controller: _pageController,
                                        itemCount: hotel.images.length,
                                        onPageChanged: hotelStorecard.changePage,
                                        itemBuilder: (context, index) {
                                          return Image.asset(
                                            hotel.images[index],
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 16,
                                      left: 16,
                                      child: circleButton(
                                        Icons.arrow_back,
                                        () => Navigator.pop(context),
                                      ),
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      child: circleButton(
                                        save == true ? Icons.bookmark : Icons.bookmark_border,
                                        savedata,
                                        color: save == true ? stayNestPrimaryColor : Colors.black,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(
                                            hotel.images.length,
                                            (index) => AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              margin: const EdgeInsets.symmetric(
                                                horizontal: 4,
                                              ),
                                              width: hotelStorecard.currentPage == index ? 20 : 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: hotelStorecard.currentPage == index ? stayNestPrimaryColor : Colors.grey[400],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                      ),
                                      child: Text(
                                        hotel.name,
                                        style: boldTextStyle(size: 22),
                                      ),
                                    ),
                                    6.height,
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: stayNestPrimaryColor,
                                          ),
                                          4.height,
                                          Expanded(
                                            child: Text(
                                              hotel.address,
                                              style: secondaryTextStyle(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.height,
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: const Color.fromARGB(
                                        255,
                                        212,
                                        211,
                                        211,
                                      ),
                                    ).paddingSymmetric(horizontal: 16),
                                    buildGallerySection(context, 1, hotel.images),
                                    20.height,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Details', style: boldTextStyle(size: 18)),
                                        8.height,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            DetailItem(
                                              icon: Icons.hotel,
                                              title: 'Hotels',
                                            ),
                                            DetailItem(
                                              icon: Icons.bed,
                                              title: '4 Bedrooms',
                                            ),
                                            DetailItem(
                                              icon: Icons.bathtub,
                                              title: '2 Bathrooms',
                                            ),
                                            DetailItem(
                                              icon: Icons.square_foot,
                                              title: '4000 sqft',
                                            ),
                                          ],
                                        ),
                                        20.height,
                                        Text(
                                          'Description',
                                          style: boldTextStyle(size: 18),
                                        ),
                                        8.height,
                                        ReadMoreText(
                                          hotel.description,
                                          trimLines: 4,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: '...Read More',
                                          trimExpandedText: ' Read Less',
                                          style: secondaryTextStyle(),
                                        ),
                                        20.height,
                                        Text(
                                          'Facilities',
                                          style: boldTextStyle(size: 18),
                                        ),
                                        8.height,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            DetailItem(
                                              icon: Icons.pool,
                                              title: 'Swimming',
                                            ),
                                            DetailItem(
                                              icon: Icons.spa,
                                              title: 'Spa',
                                            ),
                                            DetailItem(
                                              icon: Icons.restaurant,
                                              title: 'Restaurant',
                                            ),
                                            DetailItem(
                                              icon: Icons.local_parking,
                                              title: 'Parking',
                                            ),
                                          ],
                                        ),
                                        15.height,
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            DetailItem(
                                              icon: Icons.meeting_room_rounded,
                                              title: 'Meeting',
                                            ),
                                            DetailItem(
                                              icon: Icons.elevator,
                                              title: 'Elevator',
                                            ),
                                            DetailItem(
                                              icon: Icons.fitness_center,
                                              title: 'GYM',
                                            ),
                                            DetailItem(
                                              icon: Icons.hourglass_bottom,
                                              title: '24-hours',
                                            ),
                                          ],
                                        ),
                                        20.height,
                                        buildLocation(context),
                                        20.height,
                                        buildReviews(hotel.reviews),
                                        90.height,
                                      ],
                                    ).paddingSymmetric(horizontal: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: buildBottomBar(hotelCard[widget.hotelId].pricePerNight),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBar(double price) {
    return Observer(
      builder: (_) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: appStore.isDarkModeOn ? black : white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$$price / night', style: boldTextStyle(size: 16)),
            ElevatedButton(
              onPressed: () {
                SelectDateScreen(Hotelid: widget.hotelId).launch(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: stayNestPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Book Now", style: TextStyle(color: white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReviews(List<Map<String, dynamic>> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Reviews ', style: boldTextStyle(size: 18)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.star, size: 18, color: Colors.yellow),
                Text(
                  '4.2',
                  style: boldTextStyle(size: 14, color: stayNestPrimaryColor),
                ),
                Text(" (4240 rvirews)", style: secondaryTextStyle(size: 12)),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                ReviewScreen().launch(context);
              },
              child: Text('See All', style: TextStyle(color: stayNestPrimaryColor)),
            ),
          ],
        ),
        ...reviews.map((review) => reviewItem(review)),
      ],
    );
  }

  Widget buildLocation(BuildContext context) {
    final LatLng location = LatLng(
      37.7749,
      -122.4194,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: boldTextStyle(size: 18)),
        10.height,
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HotelLocationScreen()),
            );
          },
          child: Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 200,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: location,
                      initialZoom: 13,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: location,
                            width: 40,
                            height: 40,
                            alignment: Alignment.topCenter,
                            child: const Icon(
                              Icons.location_on,
                              color: stayNestPrimaryColor,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).onTap(() => HotelLocationScreen().launch(context)),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: stayNestPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    rigthArrow,
                    height: 20,
                    width: 20,
                  ).paddingAll(6),
                ).onTap(() => HotelLocationScreen().launch(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
