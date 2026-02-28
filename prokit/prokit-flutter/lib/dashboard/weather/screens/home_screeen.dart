import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/dashboard/weather/component/bottom_navigation_component.dart';
import 'package:prokit_flutter/dashboard/weather/component/forecast_card_list_component.dart';
import 'package:prokit_flutter/dashboard/weather/component/title_row_component.dart';
import 'package:prokit_flutter/dashboard/weather/component/widget_images_component.dart';
import 'package:prokit_flutter/dashboard/weather/utils/app_colors.dart';
import 'package:prokit_flutter/dashboard/weather/utils/app_images.dart';
import 'package:prokit_flutter/dashboard/weather/utils/app_string.dart';
import 'package:prokit_flutter/dashboard/weather/utils/common.dart';

WeatherAppColors weatherAppColors = WeatherAppColors();
WeatherAppImages weatherAppImages = WeatherAppImages();
WeatherAppString weatherAppString = WeatherAppString();

class WeatherDashboardScreen extends StatefulWidget {
  const WeatherDashboardScreen({super.key});
  @override
  State<WeatherDashboardScreen> createState() => _WeatherDashboardScreenState();
}

class _WeatherDashboardScreenState extends State<WeatherDashboardScreen> {
  bool _showBackgroundText = true;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(weatherAppImages.bgImage, fit: BoxFit.cover),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Image.network(weatherAppImages.house),
            ),
            if (_showBackgroundText)
              Positioned(
                top: 70.0,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          weatherAppString.city,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: weatherAppColors.white,
                          ),
                        ),
                        Text(
                          "19°",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w200,
                            color: weatherAppColors.white,
                          ),
                        ),
                        Text(
                          weatherAppString.weatherStatus,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: weatherAppColors.weatherColor,
                          ),
                        ),
                        Text(
                          "H:24° L:18°",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: weatherAppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (!_showBackgroundText)
              Positioned(
                top: 10.0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Column(
                      children: [
                        txtWidget(weatherAppString.city, 34, FontWeight.w400,
                            weatherAppColors.white),
                        txtWidget(
                          "19° | ${weatherAppString.weatherStatus}",
                          20,
                          FontWeight.w400,
                          weatherAppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            DraggableScrollableSheet(
              initialChildSize: 0.40,
              minChildSize: 0.40,
              maxChildSize: 0.8,
              snap: true,
              builder: (context, scrollController) {
                return NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    final extent = notification.extent;
                    setState(() {
                      _showBackgroundText = extent <= 0.4 + 0.01;
                    });
                    return true;
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              weatherAppColors.blurBG1,
                              weatherAppColors.blurBG2,
                              weatherAppColors.blurBG3,
                            ],
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          border: Border.all(
                            color: weatherAppColors.white
                                .withAlpha((0.2 * 255).toInt()),
                          ),
                        ),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            TitleRowComponent(),
                            Divider(
                              thickness: 1,
                              color: weatherAppColors.white.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                            ),
                            const SizedBox(height: 19),
                            ForecastCardList(),
                            const SizedBox(height: 19),
                            WidgetImages(),
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }
}
