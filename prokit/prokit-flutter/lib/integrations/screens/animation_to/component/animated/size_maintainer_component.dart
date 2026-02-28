import 'package:flutter/material.dart';


class SizeMaintainer extends StatelessWidget {
  const SizeMaintainer({
    super.key,
    required this.child,
    required this.sizeWidget,
  });
  final Widget child;
  final Widget sizeWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Opacity(opacity: 0, child: sizeWidget),
        Positioned(
          left: 0,
          top: 0,
          child: child,
        ),
      ],
    );
  }
}
