import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../model/booking_model.dart';
import '../../../utils/colors.dart';

class BookingCardComplited extends StatelessWidget {
  final Bookings booking;
  final bool isPast;
  final Function(String)? onCancel;

  const BookingCardComplited({
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking ID: ${booking.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Booking Date: ${booking.date}', style: secondaryTextStyle()),
            const SizedBox(height: 8),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      6.height,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFDFFFE2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "Completed",
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 1, thickness: 1, color: Colors.grey),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFDFFFE2),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.file_download_done_sharp,
                    color: Color(0xFF4CAF50),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "You completed this hotel booking",
                      style: TextStyle(color: Color(0xFF4CAF50), fontSize: 13),
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
