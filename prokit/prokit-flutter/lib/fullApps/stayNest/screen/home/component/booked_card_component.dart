// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../model/save_data_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../card_detail/view/card_detail_screen.dart';

class HotelCard extends StatefulWidget {
  final int id;
  final String name;
  final String address;
  final double pricePerNight;
  final double rating;
  final String image;
  final VoidCallback? onTap;

  const HotelCard({
    super.key,
    required this.id,
    required this.name,
    required this.address,
    required this.pricePerNight,
    required this.rating,
    required this.image,
    this.onTap,
  });

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool save = false;

  void toggleSave() {
    savedata.add(
      Hotel(
        id: widget.id,
        name: widget.name,
        address: widget.address,
        pricePerNight: widget.pricePerNight,
        rating: widget.rating,
        image: widget.image,
      ),
    );
    setState(() {
      save = !save;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HotelDetailScreen(hotelId: widget.id).launch(context),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.image,
                width: 90,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  4.height,
                  Text(
                    widget.address,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.height,
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      4.height,
                      Text(
                        widget.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            8.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.pricePerNight.toString()}\n/night',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: stayNestPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    save ? Icons.bookmark : Icons.bookmark_border,
                    color: save ? stayNestPrimaryColor : Colors.grey,
                  ),
                  onPressed: toggleSave,
                ),
              ],
            ),
          ],
        ).paddingAll(8),
      ),
    );
  }
}
