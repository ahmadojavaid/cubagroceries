import 'package:flutter/material.dart' hide Actions;

const rowDivider = SizedBox(width: 20);
const colDivider = SizedBox(height: 10);
const tinySpacing = 3.0;
const smallSpacing = 10.0;
const double cardWidth = 115;
const double widthConstraint = 450;

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class Sliders extends StatefulWidget {
  const Sliders({super.key});

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  double sliderValue0 = 30.0;
  double sliderValue1 = 20.0;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Sliders',
      tooltipMessage: 'Use Slider or RangeSlider',
      child: Column(
        children: <Widget>[
          Slider(
            max: 100,
            value: sliderValue0,
            onChanged: (value) {
              setState(() {
                sliderValue0 = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Slider(
            max: 100,
            divisions: 5,
            value: sliderValue1,
            label: sliderValue1.round().toString(),
            onChanged: (value) {
              setState(() {
                sliderValue1 = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class SearchAnchors extends StatefulWidget {
  const SearchAnchors({super.key});

  @override
  State<SearchAnchors> createState() => _SearchAnchorsState();
}

class _SearchAnchorsState extends State<SearchAnchors> {
  String? selectedColor;
  List<ColorItem> searchHistory = <ColorItem>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (color) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(color.label),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = color.label;
            controller.selection = TextSelection.collapsed(
              offset: controller.text.length,
            );
          },
        ),
        onTap: () {
          controller.closeView(color.label);
          handleSelection(color);
        },
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return ColorItem.values.where((color) => color.label.contains(input)).map(
          (filteredColor) => ListTile(
            leading: CircleAvatar(backgroundColor: filteredColor.color),
            title: Text(filteredColor.label),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = filteredColor.label;
                controller.selection = TextSelection.collapsed(
                  offset: controller.text.length,
                );
              },
            ),
            onTap: () {
              controller.closeView(filteredColor.label);
              handleSelection(filteredColor);
            },
          ),
        );
  }

  void handleSelection(ColorItem color) {
    setState(() {
      selectedColor = color.label;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Search',
      tooltipMessage: 'Use SearchAnchor or SearchAnchor.bar',
      child: Column(
        children: <Widget>[
          SearchAnchor.bar(
            barHintText: 'Search colors',
            suggestionsBuilder: (context, controller) {
              if (controller.text.isEmpty) {
                if (searchHistory.isNotEmpty) {
                  return getHistoryList(controller);
                }
                return <Widget>[
                  const Center(
                    child: Text(
                      'No search history.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ];
              }
              return getSuggestions(controller);
            },
          ),
          const SizedBox(height: 20),
          if (selectedColor == null)
            const Text('Select a color')
          else
            Text('Last selected color is $selectedColor'),
        ],
      ),
    );
  }
}

class Carousels extends StatelessWidget {
  const Carousels({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Carousel',
      tooltipMessage: 'Use CarouselView',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Uncontained Carousel'),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 150),
            child: CarouselView(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              shrinkExtent: 100,
              itemExtent: 180,
              children: List<Widget>.generate(20, (index) {
                return Center(child: Text('Item $index'));
              }),
            ),
          ),
          colDivider,
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Uncontained Carousel with snapping effect'),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 150),
            child: CarouselView(
              itemSnapping: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              shrinkExtent: 100,
              itemExtent: 180,
              children: List<Widget>.generate(20, (index) {
                return Center(child: Text('Item $index'));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ComponentDecoration extends StatefulWidget {
  const ComponentDecoration({
    super.key,
    required this.label,
    required this.child,
    this.tooltipMessage = '',
  });

  final String label;
  final Widget child;
  final String? tooltipMessage;

  @override
  State<ComponentDecoration> createState() => _ComponentDecorationState();
}

class _ComponentDecorationState extends State<ComponentDecoration> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: smallSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Tooltip(
                  message: widget.tooltipMessage,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(Icons.info_outline, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: widthConstraint,
              ),
              // Tapping within the a component card should request focus
              // for that component's children.
              child: Focus(
                focusNode: focusNode,
                canRequestFocus: true,
                child: GestureDetector(
                  onTapDown: (_) {
                    focusNode.requestFocus();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 20.0,
                      ),
                      child: Center(child: widget.child),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComponentGroupDecoration extends StatelessWidget {
  const ComponentGroupDecoration({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // Fully traverse this component group before moving on
    return FocusTraversalGroup(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withAlpha(77),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: Column(
              children: [
                Text(label, style: Theme.of(context).textTheme.titleLarge),
                colDivider,
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ColorItem {
  red('red', Colors.red),
  orange('orange', Colors.orange),
  yellow('yellow', Colors.yellow),
  green('green', Colors.green),
  blue('blue', Colors.blue),
  indigo('indigo', Colors.indigo),
  violet('violet', Color(0xFF8F00FF)),
  purple('purple', Colors.purple),
  pink('pink', Colors.pink),
  silver('silver', Color(0xFF808080)),
  gold('gold', Color(0xFFFFD700)),
  beige('beige', Color(0xFFF5F5DC)),
  brown('brown', Colors.brown),
  grey('grey', Colors.grey),
  black('black', Colors.black),
  white('white', Colors.white);

  const ColorItem(this.label, this.color);
  final String label;
  final Color color;
}
