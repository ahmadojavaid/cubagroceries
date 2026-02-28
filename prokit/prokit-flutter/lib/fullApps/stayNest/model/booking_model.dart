// booking_model.dart

import '../utils/images.dart';

class Bookings {
  final String id;
  final String title;
  final String date;
  final double rating;
  final int reviews;
  final String location;
  final String image;

  Bookings({
    required this.id,
    required this.title,
    required this.date,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.image,
  });
}

// Demo Upcoming Bookings
List<Bookings> bookingUpcomingData() {
  List<Bookings> demoUpcomingBookings = [];
  demoUpcomingBookings.add(
    Bookings(
      id: '22378965',
      title: 'Malon Greens',
      date: 'April 26, 2023, 10:00 PM - 03:00 PM',
      rating: 4.0,
      reviews: 115,
      location: 'Mumbai, Maharashtra',
      image: roomimage1,
    ),
  );
  demoUpcomingBookings.add(
    Bookings(
      id: '90867891',
      title: 'Sabro Prime',
      date: 'April 30, 2023, 10:00 PM - 03:00 PM',
      rating: 4.0,
      reviews: 115,
      location: 'Mumbai, Maharashtra',
      image: roomimage2,
    ),
  );

  return demoUpcomingBookings;
}

// Demo Past Bookings
List<Bookings> bookingPostData() {
  List<Bookings> demoPostData = [];
  demoPostData.add(
    Bookings(
      id: '22378965',
      title: 'Malon Greens',
      date: 'April 26, 2023, 10:00 PM - 03:00 PM',
      rating: 4.0,
      reviews: 115,
      location: 'Mumbai, Maharashtra',
      image: roomimage3,
    ),
  );
  demoPostData.add(
    Bookings(
      id: '90867891',
      title: 'Peradise Mint',
      date: 'April 30, 2023, 10:00 PM - 03:00 PM',
      rating: 4.0,
      reviews: 115,
      location: 'Mumbai, Maharashtra',
      image: roomimage2,
    ),
  );
  demoPostData.add(
    Bookings(
      id: '78001209',
      title: 'Fortune Landmark',
      date: 'April 30, 2023, 10:00 PM - 03:00 PM',
      rating: 5.0,
      reviews: 45,
      location: 'Goa, Maharashtra',
      image: roomimage1,
    ),
  );

  return demoPostData;
}

List<Bookings> cansledata() {
  List<Bookings> cansledata = [];
  cansledata.add(
    Bookings(
      id: '22378965',
      title: 'Malon Greens',
      date: 'April 26, 2023, 10:00 PM - 03:00 PM',
      rating: 4.0,
      reviews: 115,
      location: 'Mumbai, Maharashtra',
      image: roomimage1,
    ),
  );
  cansledata.add(
    Bookings(
      id: '90867891',
      title: 'Sabro Prime',
      date: 'April 30, 2023, 10:00 PM - 03:00 PM',
      rating: 4.0,
      reviews: 115,
      location: 'Mumbai, Maharashtra',
      image: roomimage2,
    ),
  );

  return cansledata;
}
