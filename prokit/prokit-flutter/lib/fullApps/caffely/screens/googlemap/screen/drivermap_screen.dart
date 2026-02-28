import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../driver_information/screen/earnreward_celebration_scree.dart';
import 'draggable_screen.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const googlePlex = LatLng(40.713527, -74.006655); // Starting point
  static const applePark = LatLng(40.714136,-74.004760); // Destination point
  final Set<Polyline> _poliline = {};
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    // Add markers for starting and destination points
    markers.add(
      Marker(
        icon: AssetMapBitmap(Images.ic_driverLocationMarker, height: 50, width: 50),
        markerId: const MarkerId("start"),
        position: googlePlex,
        infoWindow: const InfoWindow(title: "Start Point"),
      ),
    );
    markers.add(
      Marker(
        icon: AssetMapBitmap(Images.ic_blueLocationMarker, height: 40, width: 40),
        markerId: const MarkerId("destination"),
        position: applePark,
        infoWindow: const InfoWindow(title: "Destination Point"),
      ),
    );

    // Fetch polyline and update the map
    _getPolyline(googlePlex, applePark).then((polylinePoints) {
      setState(() {
        _poliline.add(
          Polyline(
            polylineId: const PolylineId("polylineId"),
            points: polylinePoints,
            width: 5,
            color: Colors.blue, // Set color to blue for the polyline
          ),
        );
      });
    }).catchError((e) {
      if (kDebugMode) {
        print('Error occurred while fetching polyline: $e');
      }
    });

    // Show alert after 5 seconds
    Future.delayed(const Duration(seconds: 10), () {
      _showAlertDialog();
    });
  }

  // Get polyline from OSRM API
  Future<List<LatLng>> _getPolyline(LatLng origin, LatLng destination) async {
    final String url = 'http://router.project-osrm.org/route/v1/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?geometries=polyline';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String encodedPolyline = data['routes'][0]['geometry'];
      return _decodePolyline(encodedPolyline);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  // Decode the polyline from the response
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
        index++;
      } while (b >= 0x20);

      int dLat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
        index++;
      } while (b >= 0x20);

      int dLng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dLng;

      polylinePoints.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polylinePoints;
  }

  // Function to show the alert dialog
  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Driver Has Arrived",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: PickColor.brownColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 13),
                const Text(
                  "The driver has arrived and brought your order",
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
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
                              MaterialPageRoute(builder: (context) => const EarnRewardCelebrationScreen()),
                            );
                          },
                          child: const Text("Ok", style: TextStyle(color: PickColor.whiteColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 10,
            child: Icon(Icons.arrow_back_ios),
          ),
          GoogleMap(
            polylines: _poliline,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: googlePlex,
              zoom: 16, // Adjust zoom level to fit the route
            ),
            markers: markers, // Add markers to the map
          ),
          Positioned(
            top: 40.0,
            left: 30.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Go back when icon is tapped
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: PickColor.brownColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100.0,
            right: 30.0,
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: PickColor.brownColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                child: Image.asset(
                  Images.ic_currentLocationLogo,
                  height: 25,
                  width: 25,
                  color: PickColor.whiteColor,
                ),
              ),
            ),
          ),
          const DraggableScreen(),
        ],
      ),
    );
  }
}
