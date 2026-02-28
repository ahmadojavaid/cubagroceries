import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: stayNestPrimaryColor,
                    child: Icon(Icons.check, color: Colors.white, size: 40),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0.1,
                        child: Image.asset(sparkle, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text("Thank you for review", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: stayNestPrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text("Go To Home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
