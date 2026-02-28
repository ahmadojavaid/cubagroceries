import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main/utils/AppColors.dart';
import '../../../../main/utils/AppWidget.dart';
import 'component/blur_fade_widget.dart';

class BlurFadeExample extends StatefulWidget {
  static String tag = '/blur_fade_fx';

  final bool isDirect;

  BlurFadeExample({this.isDirect = false});

  @override
  State<BlurFadeExample> createState() => _BlurFadeExampleState();
}

class _BlurFadeExampleState extends State<BlurFadeExample> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "BlurFade Animation", isDashboard: widget.isDirect),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlurFade(
              isVisible: _isVisible,
              child: titleText('Hello, World! 👋'),
            ),
            16.height,
            BlurFade(
              delay: const Duration(milliseconds: 100),
              isVisible: _isVisible,
              child: normalText('Nice...........'),
            ),
            16.height,
            BlurFade(
              delay: const Duration(milliseconds: 200),
              isVisible: _isVisible,
              child: normalText('to...........'),
            ),
            16.height,
            BlurFade(
              delay: const Duration(milliseconds: 300),
              isVisible: _isVisible,
              child: normalText('meet...........'),
            ),
            16.height,
            BlurFade(
              delay: const Duration(milliseconds: 400),
              isVisible: _isVisible,
              child: normalText('you...........'),
            ),
            const SizedBox(height: 60),
            AppButton(
              onTap: () => setState(() => _isVisible = !_isVisible),
              text: _isVisible ? 'Hide' : 'Show',
              textStyle: boldTextStyle(color: white),
              color: appColorPrimary,
              width: 150,
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(22)),
            ),
          ],
        ),
      ),
    );
  }

  Text normalText(String text) {
    return Text(text, style: boldTextStyle(size: 24));
  }

  Text titleText(String title) {
    return Text(title, style: boldTextStyle(size: 32));
  }
}
