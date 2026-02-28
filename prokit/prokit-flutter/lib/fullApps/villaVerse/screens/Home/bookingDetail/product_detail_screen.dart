import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/bookingDetail/see_all_comments.dart';

import '../../../component/see_all_text_row.dart';
import '../../../models/product_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import '../../../../../main.dart';
import 'book_real_estate_date_selection.dart';
import 'bookingComponents/facilities_icon.dart';
import 'bookingComponents/gallery_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel featuredProduct;

  const ProductDetailScreen({super.key, required this.featuredProduct});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      appStore.isDarkModeOn
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
    );
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: Stack(
        children: [
          ListView(
            children: [
              // Image at the top of the screen
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 350, // Set a height to control the image size
                      width: context.width(),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(widget.featuredProduct.imagePath),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    left: 0,
                    right: 0,
                    child: ListTile(
                      leading: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: radius(50)),
                        color: lightColor,
                        child: GestureDetector(
                          onTap: () => finish(context),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: radius(50)),
                            color: lightColor,
                            child: Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: darkColor,
                            ).paddingAll(5),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => setState(() {
                              widget.featuredProduct.isFavorite =
                                  !widget.featuredProduct.isFavorite;
                            }),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: radius(50)),
                              color: lightColor,
                              child: Icon(
                                widget.featuredProduct.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: darkColor,
                                size: 26,
                              ).paddingAll(5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Back button positioned on top

              20.height,
              Text(
                widget.featuredProduct.titleText,
                style: primaryTextStyle(),
              ).paddingSymmetric(horizontal: 16),
              16.height,

              // row of review and rating
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 00,
                    color: appStore.isDarkModeOn ? seconderyBlue : blueLight,
                    child: Center(
                      child: Text(
                        "Apartment",
                        style: TextStyle(color: primaryBlueColor),
                      ).paddingSymmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                  16.width,
                  Icon(
                    Icons.star,
                    color: Colors.yellow[600],
                  ),
                  10.width,
                  Text(
                    "4.7 (1,275 reviews)",
                  )
                ],
              ).paddingSymmetric(horizontal: 12),
              16.height,

              Row(
                children: [
                  facilities(FontAwesomeIcons.bed, "8 Beds"),
                  16.width,
                  facilities(Icons.bathtub, "3 bath"),
                  16.width,
                  facilities(Icons.zoom_out_map, "2000 sqft"),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Divider(
                color: Theme.of(context).dividerColor,
              ).paddingSymmetric(horizontal: 16),
              16.height,
              listTile(
                'Hardi Patel',
                'Owner',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.message, color: primaryBlueColor),
                    10.width,
                    Icon(Icons.phone, color: primaryBlueColor),
                  ],
                ),
              ),
              20.height,
              titleText("Overview"),

              12.height,
              ReadMoreText(
                colorClickableText: primaryBlueColor,
                textAlign: TextAlign.justify,
                "Real estate websites are digital platforms that connect buyers, sellers, renters, and agents by providing property listings, market insights, and transaction tools. They range from large listing sites like Zillow and Realtor.com, which offer extensive property databases with advanced search filters, interactive maps, and high-quality photos, to agency-specific sites showcasing individual agents and their services. Key features often include user-friendly interfaces, mobile optimization, and secure lead capture forms. Emerging trends include AI integration for personalized recommendations and enhanced listing accuracy. Overall, these sites simplify property searching and help users make informed real estate decisions efficiently.",
              ).paddingSymmetric(horizontal: 16),
              20.height,
              titleText("Facilities"),
              12.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FacilitiesIcon(icon: FontAwesomeIcons.car, text: "Parking"),
                  FacilitiesIcon(
                      icon: FontAwesomeIcons.personSwimming, text: "Swimming"),
                  FacilitiesIcon(icon: FontAwesomeIcons.dumbbell, text: "Gym"),
                  FacilitiesIcon(icon: Icons.restaurant, text: "Restaurant"),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FacilitiesIcon(icon: Icons.wifi, text: "Wi-fi"),
                  FacilitiesIcon(icon: Icons.pets, text: "Pet Center"),
                  FacilitiesIcon(
                      icon: Icons.sports_baseball, text: "Sport Center"),
                  FacilitiesIcon(
                      icon: Icons.local_laundry_service, text: "Laundry"),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              SeeAllTextRow(
                  text: 'Gallery',
                  voidCallback: () => GalleryScreen().launch(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  galleryImage(welcomeImage1),
                  galleryImage(welcomeImage2),
                  galleryImage(welcomeImage3),
                  Stack(
                    children: [
                      galleryImage(interior1),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: boxDecorationDefault(
                              borderRadius: BorderRadius.circular(16),
                              color: Color.fromRGBO(5, 5, 5, .5)),
                          child: Center(
                              child: Text('20+',
                                  style: TextStyle(
                                      color: lightColor, fontSize: 16))),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              20.height,

              titleText("Location"),
              12.height,
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryBlueColor,
                  ),
                  16.width,
                  RichText(
                    text: TextSpan(
                      text: "Grand City St.100, New York, United States",
                      style: secondaryTextStyle(),
                    ),
                  ),
                  16.height,
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              SizedBox(
                height: 200,
                width: context.width(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: flutter_map.FlutterMap(
                    options: flutter_map.MapOptions(
                      initialCenter: LatLng(40.717605, -74.003071),
                      initialZoom: 16,
                    ),
                    children: [
                      flutter_map.TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        tileBuilder: appStore.isDarkModeOn
                            ? customDarkModeTileBuilder
                            : null,
                        userAgentPackageName: 'com.example.app',
                      ),
                      flutter_map.MarkerLayer(
                        markers: [
                          flutter_map.Marker(
                            point: LatLng(40.717605, -74.003071),
                            child: Icon(
                              Icons.location_on,
                              color: primaryBlueColor,
                              size: 30,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 16),
              16.height,
              ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                title: Text(
                  '4.8 (1,275 reviews)',
                ),
                trailing: TextButton(
                  onPressed: () => SeeAllComments().launch(
                    context,
                  ),
                  child: Text(
                    'See All',
                    style: TextStyle(color: primaryBlueColor, fontSize: 16),
                  ),
                ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(profileImage),
                    ),
                  ),
                ),
                title: Text(
                  'Charlotte Harlin',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 0,
                      color: appStore.isDarkModeOn ? darkColor : lightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: primaryBlueColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.orangeAccent, size: 14),
                          5.width,
                          Text(
                            '5',
                            style: TextStyle(color: primaryBlueColor),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 5),
                    ),
                  ],
                ),
              ),
              Text(
                textAlign: TextAlign.justify,
                'Rease stands out as a reliable and innovative solution for those looking to rent or lease items without the commitment of ownership. Its emphasis on security, community, and sustainability makes it a top choice in the Australian rental marketplace.',
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                children: [
                  Icon(Icons.favorite_border, color: primaryBlueColor),
                  16.width,
                  Text(
                    '983',
                  ),
                  16.width,
                  Text(
                    '6 day ago',
                    style: TextStyle(color: hintTextColor),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
              120.height
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: appStore.isDarkModeOn ? darkColor : lightColor,
                border: Border(top: BorderSide(color: hintTextColor)),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$29',
                                  style: TextStyle(
                                    color: primaryBlueColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' / night',
                                  style: primaryTextStyle(size: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppButton(
                        text: 'Book Now',
                        color: primaryBlueColor,
                        textStyle: boldTextStyle(color: Colors.white),
                        width: context.width() / 2,
                        onTap: () =>
                            BookRealEstateDateSelection().launch(context),
                        shapeBorder:
                            RoundedRectangleBorder(borderRadius: radius(20)),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                ],
              ),
            ),
          )
        ],
      ),

      // bottom container
    );
  }

  Widget facilities(IconData icon, String text) {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: appStore.isDarkModeOn ? seconderyBlue : blueLight,
          ),
          child: Center(
            child: Icon(icon, size: 15, color: primaryBlueColor),
          ),
        ),
        7.width,
        Text(
          text,
        )
      ],
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ).paddingSymmetric(horizontal: 16);
  }

  Widget galleryImage(String imgPath) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 80,
          width: 80,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(imgPath),
          ),
        ));
  }

  Widget listTile(String titleText, String subTitle, Widget trailing) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(profileImage),
          ),
        ),
      ),
      title: Text(
        titleText,
      ),
      subtitle: Text(
        subTitle,
      ),
      trailing: trailing,
    );
  }

  Widget customDarkModeTileBuilder(
    BuildContext context,
    Widget tileWidget,
    flutter_map.TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );
  }

  Widget iconButton(VoidCallback voidCallBack, IconData icon) {
    return InkWell(
      onTap: voidCallBack,
      child: Icon(
        icon,
        color: darkColor,
        size: 30,
      ),
    );
  }
}
