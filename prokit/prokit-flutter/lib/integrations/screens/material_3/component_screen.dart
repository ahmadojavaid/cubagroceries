// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' hide Actions;
import 'package:nb_utils/nb_utils.dart';

import 'package:prokit_flutter/integrations/screens/material_3/components/component_catalog.dart';

const rowDivider = SizedBox(width: 20);
const colDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;

class FirstComponentList extends StatelessWidget {
  const FirstComponentList({
    super.key,
    required this.showNavBottomBar,
    required this.scaffoldKey,
    required this.showSecondList,
  });

  final bool showNavBottomBar;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool showSecondList;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const Actions(),
      10.height,
      colDivider,
      const Communication(),
      10.height,
      colDivider,
      const Containment(),
      if (!showSecondList) ...[
        10.height,
        colDivider,
        Navigation(scaffoldKey: scaffoldKey),
        10.height,
        colDivider,
        const Selection(),
        10.height,
        colDivider,
        const TextInputs(),
      ],
    ];
    List<double?> heights = List.filled(children.length, null);

    // Fully traverse this list before moving on.
    return FocusTraversalGroup(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: showSecondList
                ? const EdgeInsetsDirectional.only(end: smallSpacing)
                : EdgeInsets.zero,
            sliver: SliverList(
              delegate: BuildSlivers(
                heights: heights,
                builder: (context, index) {
                  return CacheHeight(
                    heights: heights,
                    index: index,
                    child: children[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondComponentList extends StatelessWidget {
  const SecondComponentList({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Navigation(scaffoldKey: scaffoldKey),
      colDivider,
      const Selection(),
      colDivider,
      const TextInputs(),
    ];
    List<double?> heights = List.filled(children.length, null);

    // Fully traverse this list before moving on.
    return FocusTraversalGroup(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsetsDirectional.only(end: smallSpacing),
            sliver: SliverList(
              delegate: BuildSlivers(
                heights: heights,
                builder: (context, index) {
                  return CacheHeight(
                    heights: heights,
                    index: index,
                    child: children[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
