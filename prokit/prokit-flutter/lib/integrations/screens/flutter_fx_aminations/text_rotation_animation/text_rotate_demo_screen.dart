import 'package:flutter/material.dart';

import '../../../../main/utils/AppWidget.dart';
import 'component/rotating_text_widget.dart';

class TextRotateDemoScreen extends StatefulWidget {
  static String tag = '/text_rotation_fx';

  final bool isDirect;

  TextRotateDemoScreen({this.isDirect = false});

  @override
  _TextRotateDemoScreenState createState() => _TextRotateDemoScreenState();
}

class _TextRotateDemoScreenState extends State<TextRotateDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Text Rotation Animation", isDashboard: widget.isDirect),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: const IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: RotatingTextWidget(
                          text: 'Your rotating text here',
                          radius: 100.0,
                          textStyle: TextStyle(fontSize: 18, color: Colors.blue),
                          rotationDuration: Duration(seconds: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
