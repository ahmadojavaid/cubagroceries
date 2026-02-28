import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:water_fx/water_fx.dart';

import '../../main/utils/AppWidget.dart';

class WaterFxEffectScreen extends StatelessWidget {
  static String tag = '/water_fx_effect';

  final bool isDirect;

  WaterFxEffectScreen({this.isDirect = false});

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: boldTextStyle(size: 16)),
        Expanded(child: Text(text, style: primaryTextStyle(size: 16))),
      ],
    ).paddingOnly(left: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "WaterFx Effect", isDashboard: isDirect),
      body: AnimatedScrollView(
        listAnimationType: ListAnimationType.FadeIn,
        fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.height,
              Text(
                'WaterFX: Add Realistic Water Ripple Effects to Your Flutter App',
                style: boldTextStyle(size: 16),
              ),
              16.height,
              Text('✨ Key Features:', style: boldTextStyle(size: 14)),
              8.height,
              _buildBulletPoint('Realistic Water Ripples – Touch interactions create smooth, flowing ripples.'),
              _buildBulletPoint('Supports All Widgets – Apply the effect to images, videos, buttons, and more.'),
              _buildBulletPoint('Multi-Touch & Programmatic Control – Trigger ripples with a finger, pointer, or even simulate raindrops via code.'),
              16.height,
              Text(
                'Enhance your app’s visuals and engage users with interactive water effects using WaterFX! 🌊',
                style: boldTextStyle(size: 16),
              ),
              20.height,
              WaterFXContainer.simpleWidgetInstanceForPointer(
                child: Image.asset(
                  'images/integrations/img/carousal_slider_img_4.png',
                  height: 300,
                  width: context.width(),
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(8),
              ),
              20.height,
            ],
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
