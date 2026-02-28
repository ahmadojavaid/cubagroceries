import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../account/screen/fill_address_screen.dart';

class AddMyLocationScreen extends StatefulWidget {
  const AddMyLocationScreen({super.key});

  @override
  State<AddMyLocationScreen> createState() => _AddMyLocationScreenState();
}

class _AddMyLocationScreenState extends State<AddMyLocationScreen> {
  final String address = "75 9th Ave, New York, NY 10011, USA";

  Completer<GoogleMapController> _controller = Completer();
  static const googlePlex = LatLng(20.9414, 72.9387);
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    _setCurrentLocationMarker();
  }

  Future<void> _setCurrentLocationMarker() async {
    // Check location permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();

    // Add marker for current location
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    markers.add(
      Marker(
        icon: AssetMapBitmap(Images.img_userLocationMarker, height: 50, width: 50),
        markerId: const MarkerId("currentLocation"),
        position: currentLatLng,
        infoWindow: const InfoWindow(title: "Your Location"),
      ),
    );

    setState(() {});

    // Move camera to current location
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        title: const Text("Add New Address", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 10,
            child: Icon(Icons.arrow_back_ios),
          ),
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: googlePlex,
              zoom: 16,
            ),
            markers: markers,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.3,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dragging handle
                          Center(
                            child: Container(
                              width: 100,
                              height: 5,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const Text(
                            "New York",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(address, style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    backgroundColor: PickColor.brownColor,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FillAddressScreen(address: address)),
                                    );
                                  },
                                  child: const Text(
                                    "Select Location & Continue Fill Address",
                                    style: TextStyle(color: PickColor.whiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
