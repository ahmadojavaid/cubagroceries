import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../carousel_view_slider_screen.dart';

class HeroLayoutCardComponent extends StatelessWidget {
  final ImageInfoData imageInfo;

  HeroLayoutCardComponent({required this.imageInfo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: context.width() * 7 / 8,
            minWidth: context.width() * 7 / 8,
            child: Image.asset(imageInfo.url, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                imageInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                imageInfo.subTitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
