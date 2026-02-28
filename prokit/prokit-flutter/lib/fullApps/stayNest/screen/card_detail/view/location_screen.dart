// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';

class HotelLocationScreen extends StatelessWidget {
  static const LatLng hotelLatLng = LatLng(
    37.7558,
    -122.4476,
  );

  const HotelLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(title: const Text('Hotel Location'), centerTitle: true),
      body: FlutterMap(
        options: MapOptions(initialCenter: hotelLatLng, initialZoom: 15),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
            subdomains: ['a', 'b', 'c', 'd'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40,
                height: 40,
                point: hotelLatLng,
                child: const Icon(
                  Icons.location_pin,
                  color: stayNestPrimaryColor,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
