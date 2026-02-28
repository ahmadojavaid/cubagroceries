import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/carea/commons/colors.dart';
import 'package:prokit_flutter/fullApps/proScan/utils/common.dart';
import 'package:prokit_flutter/fullApps/scribblr/utils/colors.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/component/animated/animated_to_component.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/dragable_page.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/gtaph_page.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/list_page.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/list_switch.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/spring_page.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/to_do_card.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/screens/two_lines_page.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

class AnimationHome extends StatefulWidget {
  const AnimationHome({super.key});

  @override
  State<AnimationHome> createState() => _AnimationHomeState();
}

class _AnimationHomeState extends State<AnimationHome>
    with TickerProviderStateMixin {
  var _isExpanded = true;

  final _drawerScrollController = ScrollController();

  final _items = List.generate(
    100,
    (index) => index.toString(),
  );

  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final children = _items
        .map(
          (item) => _Card(
            item: item,
            index: _items.indexOf(item),
            opacity: 1.0,
            isExpanded: _isExpanded,
            vsync: this,
            enabled: true,
            controller: _scrollController,
          ),
        )
        .toList();

    return Scaffold(
      
      key: _scaffoldKey,
  drawer: _drawer(),
  appBar: appBar(
    context,
    "Animated Page",
    actions: [
      IconButton(
        icon: Icon(Icons.menu, color: appStore.isDarkModeOn ? white : black),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
    ],
  ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: switch (_isExpanded) {
              true => Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: children,
                ),
              false => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(backgroundColor: appStore.isDarkModeOn ? black : white,
        onPressed: () {
          setState(() => _isExpanded = !_isExpanded);
        },
        icon: Icon(
          _isExpanded ? Icons.collections : Icons.expand,
          color: appStore.isDarkModeOn ? white : black,
        ),
        label: Text(
          _isExpanded ? 'Collapse' : 'Expand',
          style: primaryTextStyle(),
        ),
      ),
    );
  }

  Widget _drawer(){


return Drawer(
        surfaceTintColor: appColorPrimaryDarkLight,
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _drawerScrollController,
            child: Column(
              spacing: 4,
              children: [
                _DrawerMenuItem(
                  title: 'Spring Demo',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SpringPage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
                _DrawerMenuItem(
                  title: 'Graph Demo',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GraphPage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
                _DrawerMenuItem(
                  title: 'Throwing ball',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DraggablePage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
                _DrawerMenuItem(
                  title: 'List Switch Demo',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListSwitchPage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
                _DrawerMenuItem(
                  title: 'TODO cards',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TodoCardsPage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
                _DrawerMenuItem(
                  title: 'Two line boxes',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TwoLinesPage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
                _DrawerMenuItem(
                  title: 'List menu page',
                  vsync: this,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListPage(),
                      ),
                    );
                  },
                  controller: _drawerScrollController,
                ),
              ],
            ),
          ),
        ),
      );

  }



}

/// A circle or a rectangle shaped widget to be animated with [CurveAnimatedTo].
class _Card extends StatelessWidget {
  const _Card({
    required this.item,
    required this.index,
    required this.opacity,
    required this.isExpanded,
    required this.vsync,
    required this.enabled,
    required this.controller,
  });

  final String item;
  final int index;
  final double opacity;
  final bool isExpanded;
  final TickerProvider vsync;
  final bool enabled;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final size = 60.0;
    return AnimatedTo.spring(
      appearingFrom: const Offset(100, 0),
      globalKey: GlobalObjectKey(item),
      enabled: enabled,
      verticalController: controller,
      onEnd: (cause) {
        switch (cause) {
          case AnimationEndCause.interrupted:
            break;
          case AnimationEndCause.completed:
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.primaries[int.parse(item) % Colors.primaries.length]
              .withAlpha(isExpanded ? 255 : 128),
          borderRadius: isExpanded
              ? BorderRadius.circular(100)
              : BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(2),
        width: size,
        height: size,
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              color: Colors.white.withAlpha(isExpanded ? 255 : 128),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatefulWidget {
  const _DrawerMenuItem({
    required this.title,
    required this.onTap,
    required this.vsync,
    required this.controller,
  });

  final String title;
  final VoidCallback onTap;
  final TickerProvider vsync;
  final ScrollController controller;

  @override
  State<_DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<_DrawerMenuItem> {
  var _preparing = true;
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 200), () {
      setState(() => _preparing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_preparing) {
      return const SizedBox.shrink();
    }
    return AnimatedTo.spring(
      globalKey: GlobalObjectKey(widget.title),
      appearingFrom: const Offset(0, -100),
      verticalController: widget.controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
