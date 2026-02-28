import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../utils/colors.dart';
import '../../../../../main.dart';
import '../../../utils/image.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          flutter_map.FlutterMap(
            options: flutter_map.MapOptions(
              initialCenter: LatLng(40.717605, -74.003071),
              initialZoom: 15,
              interactionOptions: const flutter_map.InteractionOptions(
                flags: flutter_map.InteractiveFlag.all,
              ),
            ),
            children: [
              flutter_map.TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                tileBuilder: appStore.isDarkModeOn ? darkThemeMap : null,
                subdomains: ['a', 'b', 'c'],
              ),
              flutter_map.MarkerLayer(
                markers: [
                  flutter_map.Marker(
                    point: LatLng(40.712829, -74.002500),
                    width: 250,
                    height: 250,
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Lottie.asset(ripperAnimation),
                        Align(
                          alignment: Alignment.center,
                          child: mapImage(imgPath: friend1),
                        ),
                      ],
                    ),
                  ),
                  flutter_map.Marker(point: LatLng(40.712854, -74.000730), child: mapImage(imgPath: interior1)),
                  flutter_map.Marker(point: LatLng(40.711076, -74.001136), child: mapImage(imgPath: interior2)),
                  flutter_map.Marker(point: LatLng(40.715868, -74.002193), child: mapImage(imgPath: interior3)),
                  flutter_map.Marker(point: LatLng(40.711574, -73.996400), child: mapImage(imgPath: interior5)),
                  flutter_map.Marker(point: LatLng(40.714997, -73.998749), child: mapImage(imgPath: interior5)),
                  flutter_map.Marker(point: LatLng(40.710137, -74.005053), child: mapImage(imgPath: interior5)),
                  flutter_map.Marker(point: LatLng(40.714386, -74.004374), child: mapImage(imgPath: interior5))
                ],
              ),
            ],
          ),
          Positioned(
            top: 70,
            right: 16,
            left: 16,
            child: Card(
              elevation: 0,
              color: appStore.isDarkModeOn ? darkColor : lightColor,
              child: ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, color: primaryBlueColor),
                    10.width,
                    Expanded(
                      child: Text(
                        'Location (within 10 km)',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                subtitle: Text(
                  'New York, United States',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(primaryBlueColor)),
                  onPressed: () {},
                  child: Text(
                    'Change',
                    style: TextStyle(color: lightColor),
                  ),
                ),
              ).paddingSymmetric(vertical: 8),
            ),
          )
        ],
      ),
    );
  }

  // dart theme for map
  Widget darkThemeMap(BuildContext context, Widget tileWidget, flutter_map.TileImage tile) {
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

  Widget mapImage({required String imgPath, double height = 60, double width = 60}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: lightColor, width: 4),
      ),
      padding: EdgeInsets.all(3),
      child: ClipOval(
        child: Image.network(
          imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}