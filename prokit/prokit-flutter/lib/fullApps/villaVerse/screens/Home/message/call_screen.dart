// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/image.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9DD9F3), Color(0xFFFC6C8F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => finish(context),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Avatar
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(friend1),
            ),
            const SizedBox(height: 24),
            // Name
            const Text(
              "Natasya Wilodra",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Duration
            const Text(
              "03:25 mins",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            // Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _callButton(icon: Icons.volume_up, color: Colors.white),
                  const SizedBox(width: 30),
                  _callButton(icon: Icons.mic_off, color: Colors.white),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () => finish(context),
                    child: _callButton(
                        icon: Icons.call_end,
                        color: Colors.redAccent,
                        isEndCall: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _callButton(
      {required IconData icon, required Color color, bool isEndCall = false}) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: isEndCall ? Colors.white : Colors.white.withOpacity(0.2),
      child: Icon(icon, color: color, size: 28),
    );
  }
}
