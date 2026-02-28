import 'package:flutter/material.dart';

import '../../../../main/utils/AppWidget.dart';
import 'component/neon_card_widget.dart';
import 'component/neon_text_component.dart';

class NeonGradientCardDemoScreen extends StatelessWidget {
  static String tag = '/neon_card_fx';

  final bool isDirect;

  NeonGradientCardDemoScreen({this.isDirect = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Neon Card Animation", isDashboard: isDirect),
      backgroundColor: Colors.black,
      body: Center(
        child: const NeonCardWidget(
          intensity: 0.5,
          glowSpread: .8,
          child: SizedBox(
            width: 300,
            height: 200,
            child: Center(
              child: NeonTextComponent(
                text: 'Neon\nGradient\nCard',
                fontSize: 44,
                gradientColors: [
                  // Pink
                  Color.fromARGB(255, 255, 41, 117),
                  Color.fromARGB(255, 255, 41, 117),
                  Color.fromARGB(255, 9, 221, 222), // Cyan
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
