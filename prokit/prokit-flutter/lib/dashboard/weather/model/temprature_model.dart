

import 'package:prokit_flutter/dashboard/weather/screens/home_screeen.dart';

class WeatherItem {
  final String time;
  final String temp;
  final String rain;
  final bool selected;
  final String icon;

  WeatherItem({
    required this.time,
    required this.temp,
    required this.rain,
    required this.selected,
    required this.icon,
  });
}

final List<WeatherItem> weatherItems = [
  WeatherItem(
    time: '12 AM',
    temp: '19°',
    rain: '30%',
    selected: false,
    icon: weatherAppImages.cloud1,
  ),
  WeatherItem(
    time: 'Now',
    temp: '19°',
    rain: '',
    selected: true,
    icon: weatherAppImages.cloud2,
  ),
  WeatherItem(
    time: '2 AM',
    temp: '18°',
    rain: '',
    selected: false,
    icon: weatherAppImages.cloud2,
  ),
  WeatherItem(
    time: '3 AM',
    temp: '19°',
    rain: '',
    selected: false,
    icon: weatherAppImages.cloud2,
  ),
  WeatherItem(
    time: '4 AM',
    temp: '19°',
    rain: '',
    selected: false,
    icon: weatherAppImages.cloud1,
  ),
  WeatherItem(
    time: '5 AM',
    temp: '18°',
    rain: '10%',
    selected: false,
    icon: weatherAppImages.cloud1,
  ),
  WeatherItem(
    time: '6 AM',
    temp: '18°',
    rain: '20%',
    selected: false,
    icon: weatherAppImages.cloud1,
  ),
  WeatherItem(
    time: '7 AM',
    temp: '18°',
    rain: '20%',
    selected: false,
    icon: weatherAppImages.cloud1,
  ),
];
