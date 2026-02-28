import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../store/hoteldata.dart';
import '../../../utils/constant.dart';

class GalleryScreen extends StatefulWidget {
  final int hotelid;

  const GalleryScreen({super.key, required this.hotelid});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final HotelStorecard store = HotelStorecard();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hotel = hotelCard[widget.hotelid];

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? Colors.white : Colors.black,
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
        title: const Text('Gallery Hotel Photos'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: hotel.images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(hotel.images[index], fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}
