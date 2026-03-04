import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_colors.dart';

/// Full-screen map picker. Returns a LatLng when the user confirms the pin.
class MapPickerScreen extends StatefulWidget {
  /// Initial coordinates to center the map on (e.g. existing address coords).
  final double? initialLatitude;
  final double? initialLongitude;

  const MapPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  // Default: Lahore center
  static const _defaultLat = 31.5204;
  static const _defaultLng = 74.3587;

  late LatLng _pickedLocation;
  bool _isLoadingLocation = false;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _pickedLocation = LatLng(
      widget.initialLatitude ?? _defaultLat,
      widget.initialLongitude ?? _defaultLng,
    );

    // If no initial coordinates, try to get current location
    if (widget.initialLatitude == null && widget.initialLongitude == null) {
      _goToCurrentLocation();
    }
  }

  Future<void> _goToCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      // Check & request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final newPos = LatLng(position.latitude, position.longitude);
      setState(() {
        _pickedLocation = newPos;
        _isLoadingLocation = false;
      });

      if (_mapReady) {
        final controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(newPos, 17));
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pin Location'),
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: widget.initialLatitude != null ? 17 : 14,
            ),
            onMapCreated: (controller) {
              _controller.complete(controller);
              setState(() => _mapReady = true);
            },
            onCameraMove: (position) {
              _pickedLocation = position.target;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Center pin (always in the middle of the map)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Icon(
                Icons.location_pin,
                size: 48,
                color: AppColors.primary,
              ),
            ),
          ),

          // Pin shadow
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Hint text at top
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Text(
                  'Move map to position the pin on your location',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          // My location FAB
          Positioned(
            right: 16,
            bottom: 100,
            child: FloatingActionButton.small(
              heroTag: 'myLocation',
              onPressed: _isLoadingLocation ? null : _goToCurrentLocation,
              backgroundColor: Colors.white,
              child: _isLoadingLocation
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location, color: AppColors.primary),
            ),
          ),

          // Confirm button at bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(_pickedLocation),
              icon: const Icon(Icons.check_rounded),
              label: const Text('Confirm Location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
