import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../model/hotel_model.dart';
import '../../../card_detail/view/card_detail_screen.dart';

class HotelHorizontalList extends StatefulWidget {
  final List<HotelModel> hotelCard;

  const HotelHorizontalList({super.key, required this.hotelCard});

  @override
  State<HotelHorizontalList> createState() => _HotelHorizontalListState();
}

class _HotelHorizontalListState extends State<HotelHorizontalList> {
  Set<int> savedHotelIds = {};

  void toggleSave(int id) {
    setState(() {
      if (savedHotelIds.contains(id)) {
        savedHotelIds.remove(id);
      } else {
        savedHotelIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    hideKeyboard(context);
    return Observer(
      builder: (_) {
        final hotels = widget.hotelCard;

        return SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              final isSaved = savedHotelIds.contains(hotel.id);

              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16 : 13,
                  right: index == hotels.length - 1 ? 16 : 0,
                ),
                child: GestureDetector(
                  onTap: () => HotelDetailScreen(hotelId: index).launch(context),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(hotel.images.first),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 12,
                              bottom: 15,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                              ),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  hotel.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hotel.address,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$${hotel.pricePerNight} / per night",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5B61F4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Text(
                                  "${hotel.reting}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 0,
                          child: IconButton(
                            onPressed: () => toggleSave(hotel.id),
                            icon: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: isSaved ? const Color(0xFF5B61F4) : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
