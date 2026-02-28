import 'package:flutter/material.dart';

import 'package:prokit_flutter/integrations/screens/animation_to/component/animated/animated_to_component.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  // Track selected item
  int? selectedIndex;

  // Sample data
  final items = List.generate(
    50,
    (index) => 'Item ${index + 1}',
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set dark theme colors
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
             Navigator.pop(context);
                         },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        title: Text("List View ",style: TextStyle(color: Colors.white),)),
      body: ListView.builder(
        itemCount: items.length,
        // controller: _controller,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedTo.spring(
            slidingFrom: Offset(200 + index * 10, 0),
            globalKey: GlobalObjectKey('selected_item-$index'),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: Colors.grey[850],
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(
                Icons.folder,
                color: Colors.blue,
                size: 28,
              ),
              title: Text(
                items[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}