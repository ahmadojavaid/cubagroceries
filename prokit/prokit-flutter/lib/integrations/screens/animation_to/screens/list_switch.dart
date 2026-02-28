import 'package:flutter/material.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/component/animated/animated_to_component.dart';

class ListSwitchPage extends StatefulWidget {
  const ListSwitchPage({super.key});

  @override
  State<ListSwitchPage> createState() => _ListSwitchPageState();
}

enum _Mode { list, grid }

class _ListSwitchPageState extends State<ListSwitchPage> {
  final List<_Item> items = [
  _Item(
    id: 'item_id_1',
    description: 'Person1',
    imagePath: 'images/banking/Banking_ic_user1.jpeg',
    iconKey: GlobalObjectKey('item_id_1_icon'),
    textKey: GlobalObjectKey('item_id_1_text'),
  ),
  _Item(
    id: 'item_id_2',
    description: 'Person2',
    imagePath: 'images/banking/Banking_ic_user2.jpg',
    iconKey: GlobalObjectKey('item_id_2_icon'),
    textKey: GlobalObjectKey('item_id_2_text'),
  ),
  _Item(
    id: 'item_id_3',
    description: 'Person3',
    imagePath: 'images/beauty_master/model_one.jpg',
    iconKey: GlobalObjectKey('item_id_3_icon'),
    textKey: GlobalObjectKey('item_id_3_text'),
  ),
  _Item(
    id: 'item_id_4',
    description: 'Person4',
    imagePath: 'images/beauty_master/model_two.jpg',
    iconKey: GlobalObjectKey('item_id_4_icon'),
    textKey: GlobalObjectKey('item_id_4_text'),
  ),
  _Item(
    id: 'item_id_5',
    description: 'Person5',
    imagePath: 'images/beauty_master/model_three.jpg',
    iconKey: GlobalObjectKey('item_id_5_icon'),
    textKey: GlobalObjectKey('item_id_5_text'),
  ),
  _Item(
    id: 'item_id_6',
    description: 'Person6',
    imagePath: 'images/coinPro/cp_user.webp',
    iconKey: GlobalObjectKey('item_id_6_icon'),
    textKey: GlobalObjectKey('item_id_6_text'),
  ),
  _Item(
    id: 'item_id_7',
    description: 'Food',
    imagePath: 'images/dashboard/d1_ic_popular1.jpg',
    iconKey: GlobalObjectKey('item_id_7_icon'),
    textKey: GlobalObjectKey('item_id_7_text'),
  ),
  _Item(
    id: 'item_id_8',
    description: 'Food',
    imagePath: 'images/dashboard/d1_ic_popular2.jpg',
    iconKey: GlobalObjectKey('item_id_8_icon'),
    textKey: GlobalObjectKey('item_id_8_text'),
  ),
  _Item(
    id: 'item_id_9',
    description: 'Food',
    imagePath: 'images/dashboard/d1_ic_popular3.jpg',
    iconKey: GlobalObjectKey('item_id_9_icon'),
    textKey: GlobalObjectKey('item_id_9_text'),
  ),
  _Item(
    id: 'item_id_10',
    description: 'Food',
    imagePath: 'images/dashboard/d1_ic_popular4.jpg',
    iconKey: GlobalObjectKey('item_id_10_icon'),
    textKey: GlobalObjectKey('item_id_10_text'),
  ),
];


  _Mode _mode = _Mode.list;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "List Switch"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton<_Mode>(
                  selected: {_mode},
                  onSelectionChanged: (Set<_Mode> newSelection) {
                    setState(() => _mode = newSelection.first);
                  },
                  segments: const [
                    ButtonSegment<_Mode>(
                      value: _Mode.list,
                      icon: Icon(Icons.view_list),
                      label: Text('List'),
                    ),
                    ButtonSegment<_Mode>(
                      value: _Mode.grid,
                      icon: Icon(Icons.grid_view),
                      label: Text('Grid'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: _mode == _Mode.list
                    ? Column(
                        children: items
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: _ListItem(
                                    item: e,
                                    scrollController: _scrollController,
                                  ),
                                ))
                            .toList(),
                      )
                    : Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: items
                            .map((e) => SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 - 30,
                                  child: _GridItem(
                                    item: e,
                                    scrollController: _scrollController,
                                  ),
                                ))
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final _Item item;
  final ScrollController scrollController;

  const _ListItem({required this.item, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AnimatedTo.spring(
        globalKey: item.textKey,
        child: Text(item.description),
      ),
      leading: AnimatedTo.spring(
        globalKey: item.iconKey,
        sizeWidget: const SizedBox(width: 60, height: 60),
        verticalController: scrollController,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            item.imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final _Item item;
  final ScrollController scrollController;

  const _GridItem({required this.item, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTo.spring(
            globalKey: item.iconKey,
            sizeWidget: SizedBox(
              width: constraints.maxWidth,
              child: AspectRatio(aspectRatio: 1),
            ),
            verticalController: scrollController,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          AnimatedTo.spring(
            globalKey: item.textKey,
            child: Text(item.description),
          ),
        ],
      );
    });
  }
}

class _Item {
  final String id;
  final String description;
  final String imagePath;
  final GlobalKey iconKey;
  final GlobalKey textKey;

  const _Item({
    required this.id,
    required this.description,
    required this.imagePath,
    required this.iconKey,
    required this.textKey,
  });
}
