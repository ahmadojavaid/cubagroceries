import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../model/booking_model.dart';
import '../../../utils/colors.dart';

class BookingCardCansle extends StatelessWidget {
  final Bookings booking;
  final bool isPast;
  final Function(String)? onCancel;

  const BookingCardCansle({
    super.key,
    required this.booking,
    required this.isPast,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking ID: ${booking.id}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            8.height,
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    booking.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: stayNestPrimaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            booking.location,
                            style: secondaryTextStyle(size: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE5E5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Canceled & Refunded",
                          style: primaryTextStyle(
                            color: Colors.redAccent,
                            size: 12,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            12.height,
            Divider(height: 1, thickness: 1, color: Colors.grey),
            12.height,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5E5),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                  8.height,
                  Expanded(
                    child: Text(
                      "You canceled this hotel booking",
                      style: secondaryTextStyle(
                        color: Colors.redAccent,
                        size: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
