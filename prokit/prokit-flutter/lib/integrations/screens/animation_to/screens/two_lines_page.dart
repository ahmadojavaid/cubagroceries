import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/scribblr/utils/colors.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/integrations/screens/animation_to/component/animated/animated_to_component.dart';

class TwoLinesPage extends StatefulWidget {
  const TwoLinesPage({super.key});

  @override
  State<TwoLinesPage> createState() => _TwoLinesPageState();
}

class _TwoLinesPageState extends State<TwoLinesPage> with TickerProviderStateMixin {
  final List<String> _leftLineItems = ['A', 'B', 'C', 'D', 'E', 'F'];
  final List<String> _rightLineItems = ['K', 'L', 'M', 'N', 'O', 'P'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Two Line Page"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _leftLineItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: _SpringItem(
                            item: item,
                            vsync: this,
                            onTap: () {
                              setState(() {
                                _leftLineItems.remove(item);
                                _rightLineItems.add(item);
                              });
                            },
                            color: Colors.amberAccent,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _rightLineItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: _SpringItem(
                            item: item,
                            vsync: this,
                            onTap: () {
                              setState(() {
                                _rightLineItems.remove(item);
                                _leftLineItems.add(item);
                              });
                            },
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
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

class _SpringItem extends StatelessWidget {
  const _SpringItem({
    required this.item,
    required this.vsync,
    required this.onTap,
    required this.color,
  });

  final String item;
  final TickerProvider vsync;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedTo.spring(
      globalKey: GlobalObjectKey(item),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Center(
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
