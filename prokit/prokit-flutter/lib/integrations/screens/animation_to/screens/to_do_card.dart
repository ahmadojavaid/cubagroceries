import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/scribblr/utils/colors.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

import 'package:prokit_flutter/integrations/screens/animation_to/component/animated/animated_to_component.dart';

class TodoCardsPage extends StatefulWidget {
  const TodoCardsPage({super.key});

  @override
  State<TodoCardsPage> createState() => _TodoCardsPageState();
}

class _TodoCardsPageState extends State<TodoCardsPage>
    with TickerProviderStateMixin {
  final List<String> _leftLineItems = ['a', 'b', 'c'];
  final List<String> _rightLineItems = ['k', 'l'];
  final List<String> _centerLineItems = ['u'];

  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "To Do Cards"),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _enabled = false;
          } else if (notification is ScrollEndNotification) {
            _enabled = true;
          }
          return false;
        },
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          children: [
            _buildColumn(_leftLineItems, Colors.amber[700]!, (item) {
              setState(() {
                _leftLineItems.remove(item);
                _centerLineItems.add(item);
              });
            }),
            const SizedBox(width: 32),
            _buildColumn(_centerLineItems, Colors.green[700]!, (item) {
              setState(() {
                _centerLineItems.remove(item);
                _rightLineItems.add(item);
              });
            }),
            const SizedBox(width: 32),
            _buildColumn(_rightLineItems, Colors.blue[700]!, (item) {
              setState(() {
                _rightLineItems.remove(item);
                _centerLineItems.add(item);
              });
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: appStore.isDarkModeOn ? black : white,
        onPressed: () {
          setState(() {
            final count = _leftLineItems.length +
                _centerLineItems.length +
                _rightLineItems.length;
            _leftLineItems.add('t${count + 1}');
          });
        },
        child:  Icon(Icons.add,color: appStore.isDarkModeOn ? white : black,),
      ),
    );
  }

  Widget _buildColumn(
      List<String> items, Color color, Function(String) onItemTap) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _Item(
                  item: item,
                  vsync: this,
                  onTap: () => onItemTap(item),
                  color: color,
                  enabled: _enabled,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.item,
    required this.vsync,
    required this.onTap,
    required this.color,
    required this.enabled,
  });

  final String item;
  final TickerProvider vsync;
  final VoidCallback onTap;
  final Color color;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedTo.spring(
      enabled: enabled,
      globalKey: GlobalObjectKey(item),
      slidingFrom: const Offset(0, 30),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TODO #$item',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sample task to complete',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
