import 'package:flutter/material.dart' hide Actions;
import 'package:prokit_flutter/integrations/screens/material_3/components/component_catalog.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/misc_ui_components.dart' hide smallSpacing, colDivider, rowDivider;

class BottomSheetSection extends StatefulWidget {
  const BottomSheetSection({super.key});

  @override
  State<BottomSheetSection> createState() => _BottomSheetSectionState();
}

class _BottomSheetSectionState extends State<BottomSheetSection> {
  bool isNonModalBottomSheetOpen = false;
  PersistentBottomSheetController? _nonModalBottomSheetController;

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonList = <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.archive_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
    ];
    List<Text> labelList = const <Text>[
      Text('Share'),
      Text('Add to'),
      Text('Trash'),
      Text('Archive'),
      Text('Settings'),
      Text('Favorite'),
    ];

    buttonList = List.generate(
      buttonList.length,
      (index) => Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [buttonList[index], labelList[index]],
        ),
      ),
    );

    return ComponentDecoration(
      label: 'Bottom sheet',
      tooltipMessage: 'Use showModalBottomSheet<T> or showBottomSheet<T>',
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          TextButton(
            child: const Text(
              'Show modal bottom sheet',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                showDragHandle: true,
                context: context,
                constraints: const BoxConstraints(maxWidth: 640),
                builder: (context) {
                  return SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: buttonList,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          TextButton(
            child: Text(
              isNonModalBottomSheetOpen ? 'Hide bottom sheet' : 'Show bottom sheet',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (isNonModalBottomSheetOpen) {
                _nonModalBottomSheetController?.close();
                setState(() {
                  isNonModalBottomSheetOpen = false;
                });
                return;
              } else {
                setState(() {
                  isNonModalBottomSheetOpen = true;
                });
              }

              _nonModalBottomSheetController = showBottomSheet(
                elevation: 8.0,
                context: context,
                constraints: const BoxConstraints(maxWidth: 640),
                builder: (context) {
                  return SizedBox(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: buttonList,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomAppBars extends StatelessWidget {
  const BottomAppBars({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Bottom app bar',
      tooltipMessage: 'Use BottomAppBar',
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                elevation: 0.0,
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  children: <Widget>[
                    const IconButtonAnchorExample(),
                    IconButton(
                      tooltip: 'Search',
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'Favorite',
                      icon: const Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconButtonAnchorExample extends StatelessWidget {
  const IconButtonAnchorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
      menuChildren: [
        MenuItemButton(child: const Text('Menu 1'), onPressed: () {}),
        MenuItemButton(child: const Text('Menu 2'), onPressed: () {}),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.1')),
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.2')),
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.3')),
          ],
          child: const Text('Menu 3'),
        ),
      ],
    );
  }
}

class ButtonAnchorExample extends StatelessWidget {
  const ButtonAnchorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return FilledButton.tonal(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Text('Show menu'),
        );
      },
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.people_alt_outlined),
          child: const Text('Item 1'),
          onPressed: () {},
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.remove_red_eye_outlined),
          child: const Text('Item 2'),
          onPressed: () {},
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.refresh),
          onPressed: () {},
          child: const Text('Item 3'),
        ),
      ],
    );
  }
}

class NavigationDrawers extends StatelessWidget {
  const NavigationDrawers({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Navigation drawer',
      tooltipMessage: 'Use NavigationDrawer. For modal navigation drawers, see Scaffold.endDrawer',
      child: Column(
        children: [
          const SizedBox(height: 520, child: NavigationDrawerSection()),
          colDivider,
          colDivider,
          TextButton(
            child: const Text(
              'Show modal navigation drawer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}

class NavigationDrawerSection extends StatefulWidget {
  const NavigationDrawerSection({super.key});

  @override
  State<NavigationDrawerSection> createState() => _NavigationDrawerSectionState();
}

class _NavigationDrawerSectionState extends State<NavigationDrawerSection> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navDrawerIndex = selectedIndex;
        });
      },
      selectedIndex: navDrawerIndex,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Mail', style: Theme.of(context).textTheme.titleSmall),
        ),
        ...destinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
        const Divider(indent: 28, endIndent: 28),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Labels', style: Theme.of(context).textTheme.titleSmall),
        ),
        ...labelDestinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
      ],
    );
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination('Inbox', Icon(Icons.inbox_outlined), Icon(Icons.inbox)),
  ExampleDestination('Outbox', Icon(Icons.send_outlined), Icon(Icons.send)),
  ExampleDestination(
    'Favorites',
    Icon(Icons.favorite_outline),
    Icon(Icons.favorite),
  ),
  ExampleDestination('Trash', Icon(Icons.delete_outline), Icon(Icons.delete)),
];

const List<ExampleDestination> labelDestinations = <ExampleDestination>[
  ExampleDestination(
    'Family',
    Icon(Icons.bookmark_border),
    Icon(Icons.bookmark),
  ),
  ExampleDestination(
    'School',
    Icon(Icons.bookmark_border),
    Icon(Icons.bookmark),
  ),
  ExampleDestination('Work', Icon(Icons.bookmark_border), Icon(Icons.bookmark)),
];

class NavigationRails extends StatelessWidget {
  const NavigationRails({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentDecoration(
      label: 'Navigation rail',
      tooltipMessage: 'Use NavigationRail',
      child: IntrinsicWidth(
        child: SizedBox(height: 420, child: NavigationRailSection()),
      ),
    );
  }
}

class NavigationRailSection extends StatefulWidget {
  const NavigationRailSection({super.key});

  @override
  State<NavigationRailSection> createState() => _NavigationRailSectionState();
}

class _NavigationRailSectionState extends State<NavigationRailSection> {
  int navRailIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navRailIndex = selectedIndex;
        });
      },
      elevation: 4,
      leading: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {},
      ),
      groupAlignment: 0.0,
      selectedIndex: navRailIndex,
      labelType: NavigationRailLabelType.selected,
      destinations: <NavigationRailDestination>[
        ...destinations.map((destination) {
          return NavigationRailDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
      ],
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Tabs',
      tooltipMessage: 'Use TabBar',
      child: SizedBox(
        height: 80,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  icon: Icon(Icons.videocam_outlined),
                  text: 'Video',
                  iconMargin: EdgeInsets.only(bottom: 0.0),
                ),
                Tab(
                  icon: Icon(Icons.photo_outlined),
                  text: 'Photos',
                  iconMargin: EdgeInsets.only(bottom: 0.0),
                ),
                Tab(
                  icon: Icon(Icons.audiotrack_sharp),
                  text: 'Audio',
                  iconMargin: EdgeInsets.only(bottom: 0.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopAppBars extends StatelessWidget {
  const TopAppBars({super.key});

  static final actions = [
    IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
    IconButton(icon: const Icon(Icons.event), onPressed: () {}),
    IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Top app bars',
      tooltipMessage: 'Use AppBar, SliverAppBar, SliverAppBar.medium, or  SliverAppBar.large',
      child: Column(
        children: [
          AppBar(
            title: const Text('Center-aligned'),
            leading: const BackButton(),
            actions: [
              IconButton(
                iconSize: 32,
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {},
              ),
            ],
            centerTitle: true,
          ),
          colDivider,
          AppBar(
            title: const Text('Small'),
            leading: const BackButton(),
            actions: actions,
            centerTitle: false,
          ),
          colDivider,
          SizedBox(
            height: 100,
            child: CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  title: const Text('Medium'),
                  leading: const BackButton(),
                  actions: actions,
                ),
                const SliverFillRemaining(),
              ],
            ),
          ),
          colDivider,
          SizedBox(
            height: 130,
            child: CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: const Text('Large'),
                  leading: const BackButton(),
                  actions: actions,
                ),
                const SliverFillRemaining(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon = IconLabel.smile;
  ColorLabel? selectedColor;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries = <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
          enabled: color.label != 'Grey',
        ),
      );
    }

    final List<DropdownMenuEntry<IconLabel>> iconEntries = <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries.add(
        DropdownMenuEntry<IconLabel>(value: icon, label: icon.label),
      );
    }

    return ComponentDecoration(
      label: 'Menus',
      tooltipMessage: 'Use MenuAnchor or DropdownMenu<T>',
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonAnchorExample(),
              rowDivider,
              IconButtonAnchorExample(),
            ],
          ),
          colDivider,
          Wrap(
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: smallSpacing,
            runSpacing: smallSpacing,
            children: [
              DropdownMenu<ColorLabel>(
                controller: colorController,
                label: const Text('Color'),
                enableFilter: true,
                dropdownMenuEntries: colorEntries,
                inputDecorationTheme: const InputDecorationTheme(filled: true),
                onSelected: (color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              DropdownMenu<IconLabel>(
                initialSelection: IconLabel.smile,
                controller: iconController,
                leadingIcon: const Icon(Icons.search),
                label: const Text('Icon'),
                dropdownMenuEntries: iconEntries,
                onSelected: (icon) {
                  setState(() {
                    selectedIcon = icon;
                  });
                },
              ),
              Icon(
                selectedIcon?.icon,
                color: selectedColor?.color ?? Colors.grey.withAlpha(128),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
