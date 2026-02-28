import 'package:flutter/material.dart';

import '../../../../main/utils/AppWidget.dart';
import 'component/tech_stack_cloud_component.dart';

// Example page using the TechStackCloud
class Tech3dCloudStackDemoScreen extends StatelessWidget {
  static String tag = '/interactive_globe_logos_fx';

  final bool isDirect;

  Tech3dCloudStackDemoScreen({this.isDirect = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Interactive Globe Logos Animation", isDashboard: isDirect),
      body: TechStackCloudComponent(),
    );
  }
}
