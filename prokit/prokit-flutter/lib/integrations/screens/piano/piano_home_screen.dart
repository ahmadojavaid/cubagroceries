
import 'package:flutter/material.dart';
import 'package:prokit_flutter/integrations/screens/piano/keybords/piano_with_32c.dart';
import 'package:prokit_flutter/integrations/screens/piano/keybords/piano_with_32f.dart';
import 'package:prokit_flutter/integrations/screens/piano/keybords/piano_with_36c.dart';
import 'package:prokit_flutter/integrations/screens/piano/keybords/piano_with_54.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

class PianoHomeScreen extends StatefulWidget {
  const PianoHomeScreen({super.key});

  @override
  State<PianoHomeScreen> createState() => _PianoHomeScreenState();
}

class _PianoHomeScreenState extends State<PianoHomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBar(context,"Piano"),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildPianoCard(title: '32 Keys start with C', child:  PianoWith32c()),
            _buildPianoCard(title: '32 Keys start with F', child:  PianoWith32f()),
            _buildPianoCard(title: '36 Keys start with C', child:  PianoWith36c()),
            _buildPianoCard(title: '54 Keys', child:  PianoWith54()),
          ],
        ),
      ),
    );
  }

  Widget _buildPianoCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      color: Colors.grey,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

