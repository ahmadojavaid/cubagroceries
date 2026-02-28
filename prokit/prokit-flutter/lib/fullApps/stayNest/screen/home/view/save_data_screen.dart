import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../model/save_data_model.dart';
import '../../../utils/colors.dart';
import '../../card_detail/view/card_detail_screen.dart';

class SaveDataScreen extends StatefulWidget {
  const SaveDataScreen({super.key});

  @override
  State<SaveDataScreen> createState() => _SaveDataScreenState();
}

class _SaveDataScreenState extends State<SaveDataScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Hotel> hotels = saveData();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
        title: Text(
          'Saved Hotels',
          style: primaryTextStyle(size: 20),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return BookedCardComponent(hotel: hotels[index]).paddingBottom(16);
        },
      ),
    );
  }
}

class BookedCardComponent extends StatefulWidget {
  final Hotel hotel;

  const BookedCardComponent({super.key, required this.hotel});

  @override
  State<BookedCardComponent> createState() => _BookedCardComponentState();
}

class _BookedCardComponentState extends State<BookedCardComponent> {
  bool save = true;

  void toggleSave() {
    setState(() {
      save = !save;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          HotelDetailScreen(hotelId: widget.hotel.id).launch(context);
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.hotel.image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.hotel.name, style: boldTextStyle(size: 16)),
                    4.height,
                    Text(
                      widget.hotel.address,
                      style: secondaryTextStyle(size: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.height,
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        4.width,
                        Text(
                          widget.hotel.rating.toStringAsFixed(1),
                          style: primaryTextStyle(size: 13),
                        ),
                        6.width,
                        Text(
                          '(4,000 reviews)',
                          style: secondaryTextStyle(size: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              8.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${widget.hotel.pricePerNight.toStringAsFixed(0)}",
                    style: boldTextStyle(size: 16, color: stayNestPrimaryColor),
                  ),
                  Text('/ night', style: secondaryTextStyle(size: 12)),
                  8.height,
                  IconButton(
                    onPressed: toggleSave,
                    icon: Icon(
                      save ? Icons.bookmark : Icons.bookmark_outline,
                      color: save ? stayNestPrimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
