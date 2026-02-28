import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main/utils/AppWidget.dart';
import 'component/border_beam_widget.dart';

class BorderBeamHomeScreen extends StatelessWidget {
  static String tag = '/border_beam_fx';

  final bool isDirect;

  BorderBeamHomeScreen({this.isDirect = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Border Beam Animation", isDashboard: isDirect),
      backgroundColor: Colors.black,
      body: Center(
        child: BorderBeamWidget(
          duration: 7,
          colorFrom: Colors.blue,
          colorTo: Colors.purple,
          staticBorderColor: const Color.fromARGB(255, 39, 39, 40),
          borderRadius: BorderRadius.circular(20),
          padding: EdgeInsets.all(16),
          child: Container(
            width: 200,
            height: 200,
            child: Center(
              child: Text('Border Beam', style: boldTextStyle(size: 24, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
