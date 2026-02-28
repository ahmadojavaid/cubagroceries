import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../model/booking_model.dart';
import '../../../utils/colors.dart';
import '../../card_detail/view/ticket_screen.dart';

class BookingCardOngoing extends StatelessWidget {
  final Bookings booking;
  final bool isPast;
  final Function(String)? onCancel;

  const BookingCardOngoing({
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
            4.height,
            Text('Booking Date: ${booking.date}', style: secondaryTextStyle()),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < booking.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                          Text(
                            ' ${booking.rating} (${booking.reviews} Reviews)',
                            style: secondaryTextStyle(size: 12),
                          ),
                        ],
                      ),
                      Text(booking.title, style: TextStyle()),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: stayNestPrimaryColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Marquee(
                              
                              direction: Axis.horizontal,
                              child: Text(
                                booking.location,
                                style: secondaryTextStyle(size: 16),
                                overflow: TextOverflow
                                    .visible, // Important for scrollable text
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            12.height,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isPast) {
                      } else {
                        onCancel?.call(booking.id);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: appStore.isDarkModeOn ? white : white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(isPast ? 'Review' : 'Cancel',
                        style: TextStyle(
                            color: appStore.isDarkModeOn
                                ? whiteColor
                                : blackColor)),
                  ),
                ),
                12.width,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isPast) {
                      } else {
                        TicketScreen().launch(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: stayNestPrimaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(isPast ? 'Book Again' : 'View Details'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
