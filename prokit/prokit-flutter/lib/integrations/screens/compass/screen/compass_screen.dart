import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prokit_flutter/fullApps/proScan/utils/common.dart';
import 'package:prokit_flutter/fullApps/scribblr/utils/colors.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    init();
    _fetchPermissionStatus();
  }

  void init() async {
    changeStatusColor(appStore.scaffoldBackground!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appBar(context, "Compass"),
      body: _hasPermissions
          ? Center(child: _buildCompass())
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}', style: const TextStyle(color: Colors.white));
        }

        if (!snapshot.hasData || snapshot.data?.heading == null) {
          return const Text("Compass not available", style: TextStyle(color: Colors.white));
        }

        final double direction = snapshot.data!.heading!;
        final int directionDegrees = direction.round();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appStore.isDarkModeOn? white:Colors.grey[300],
              ),
              child: Transform.rotate(
                angle: (direction * (math.pi / 180) * -1),
                child: Image.asset(
                  'images/compass/images/compass.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "$directionDegrees°",
              style: primaryTextStyle()
            ),
            const SizedBox(height: 4),
             Text(
              'Magnetic Heading',
              style: primaryTextStyle()
            ),
          ],
        );
      },
    );
  }

  void _fetchPermissionStatus() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      setState(() => _hasPermissions = true);
    } else {
      await Permission.locationWhenInUse.request();
      final updatedStatus = await Permission.locationWhenInUse.status;
      setState(() => _hasPermissions = updatedStatus.isGranted);
    }
  }
}
