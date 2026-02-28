import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NeonTextComponent extends StatelessWidget {
  final String text;
  final int fontSize;
  final List<Color> gradientColors;

  const NeonTextComponent({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradientColors,
          stops: const [0.0, 0.3, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: boldTextStyle(
          size: fontSize,
          height: 1,
          letterSpacing: -1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
