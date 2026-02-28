import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/interactive_material_widgets.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/material_component_examples.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/material_scaffold_components.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/misc_ui_components.dart';

const rowDivider = SizedBox(width: 20);
const colDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;

class CacheHeight extends SingleChildRenderObjectWidget {
  const CacheHeight({super.child, required this.heights, required this.index});

  final List<double?> heights;
  final int index;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCacheHeight(heights: heights, index: index);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCacheHeight renderObject,
  ) {
    renderObject
      ..heights = heights
      ..index = index;
  }
}

class _RenderCacheHeight extends RenderProxyBox {
  _RenderCacheHeight({required List<double?> heights, required int index})
      : _heights = heights,
        _index = index,
        super();

  List<double?> _heights;
  List<double?> get heights => _heights;
  set heights(List<double?> value) {
    if (value == _heights) {
      return;
    }
    _heights = value;
    markNeedsLayout();
  }

  int _index;
  int get index => _index;
  set index(int value) {
    if (value == index) {
      return;
    }
    _index = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    super.performLayout();
    heights[index] = size.height;
  }
}

// The heights information is used to override the `estimateMaxScrollOffset` and
// provide a more accurate estimation for the max scroll offset.
class BuildSlivers extends SliverChildBuilderDelegate {
  BuildSlivers({
    required NullableIndexedWidgetBuilder builder,
    required this.heights,
  }) : super(builder, childCount: heights.length);

  final List<double?> heights;

  @override
  double? estimateMaxScrollOffset(
    int firstIndex,
    int lastIndex,
    double leadingScrollOffset,
    double trailingScrollOffset,
  ) {
    return heights.reduce((sum, height) => (sum ?? 0) + (height ?? 0))!;
  }
}

Widget _wrapWithPadding(Widget child) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0), child: child);

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
      label: 'Actions',
      children: const [
        Buttons(),
        FloatingActionButtons(),
        IconToggleButtons(),
        SegmentedButtons(),
      ].map((widget) => widget.paddingSymmetric(horizontal: 16)).toList(),
    );
  }
}

class Communication extends StatelessWidget {
  const Communication({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
      label: 'Communication',
      children: const [
        NavigationBars(
            selectedIndex: 1, isExampleBar: true, isBadgeExample: true),
        ProgressIndicators(),
        SnackBarSection(),
      ].map(_wrapWithPadding).toList(),
    );
  }
}

class Containment extends StatelessWidget {
  const Containment({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
      label: 'Containment',
      children: const [
        BottomSheetSection(),
        Cards(),
        Carousels(),
        Dialogs(),
        Dividers(),
      ].map(_wrapWithPadding).toList(),
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
      label: 'Navigation',
      children: [
        const BottomAppBars(),
        const NavigationBars(selectedIndex: 0, isExampleBar: true),
        NavigationDrawers(scaffoldKey: scaffoldKey),
        const NavigationRails(),
        const Tabs(),
        const SearchAnchors(),
        const TopAppBars(),
      ].map(_wrapWithPadding).toList(),
    );
  }
}

class Selection extends StatelessWidget {
  const Selection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
      label: 'Selection',
      children: const [
        Checkboxes(),
        Chips(),
        DatePicker(),
        TimePicker(),
        Menus(),
        Radios(),
        Sliders(),
        Switches(),
      ].map(_wrapWithPadding).toList(),
    );
  }
}

class TextInputs extends StatelessWidget {
  const TextInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentGroupDecoration(
      label: 'Text inputs',
      children: const [
        TextFields(),
      ].map(_wrapWithPadding).toList(),
    );
  }
}

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return const ComponentDecoration(
      label: 'Common buttons',
      tooltipMessage:
          'Use ElevatedButton, FilledButton, FilledButton.tonal, OutlinedButton, or TextButton',
      child: ButtonsRow(),
    );
  }
}

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ButtonsWithoutIcon(isDisabled: false),
            ButtonsWithIcon(),
            ButtonsWithoutIcon(isDisabled: true),
          ],
        ).fit(),
      ),
    );
  }
}

class ButtonsWithoutIcon extends StatelessWidget {
  final bool isDisabled;

  const ButtonsWithoutIcon({super.key, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: isDisabled ? null : () {},
            child: const Text('Elevated'),
          ),
          colDivider,
          FilledButton(
            onPressed: isDisabled ? null : () {},
            child: const Text('Filled'),
          ),
          colDivider,
          FilledButton.tonal(
            onPressed: isDisabled ? null : () {},
            child: const Text('Filled tonal'),
          ),
          colDivider,
          OutlinedButton(
            onPressed: isDisabled ? null : () {},
            child: const Text('Outlined'),
          ),
          colDivider,
          TextButton(
            onPressed: isDisabled ? null : () {},
            child: const Text('Text'),
          ),
        ],
      ),
    );
  }
}

class ButtonsWithIcon extends StatelessWidget {
  const ButtonsWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon'),
            ),
            colDivider,
            FilledButton.icon(
              onPressed: () {},
              label: const Text('Icon'),
              icon: const Icon(Icons.add),
            ),
            colDivider,
            FilledButton.tonalIcon(
              onPressed: () {},
              label: const Text('Icon'),
              icon: const Icon(Icons.add),
            ),
            colDivider,
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon'),
            ),
            colDivider,
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Icon'),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Floating action buttons',
      tooltipMessage:
          'Use FloatingActionButton or FloatingActionButton.extended',
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: smallSpacing,
        spacing: smallSpacing,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            onPressed: () {},
            tooltip: 'Small',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {},
            tooltip: 'Extended',
            icon: const Icon(Icons.add),
            label: const Text('Create'),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            tooltip: 'Standard',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.large(
            heroTag: null,
            onPressed: () {},
            tooltip: 'Large',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Cards',
      tooltipMessage: 'Use Card',
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: cardWidth,
            child: Card(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Elevated'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Filled'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: cardWidth,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Outlined'),
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

class ClearButton extends StatelessWidget {
  const ClearButton({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => controller.clear(),
      );
}
