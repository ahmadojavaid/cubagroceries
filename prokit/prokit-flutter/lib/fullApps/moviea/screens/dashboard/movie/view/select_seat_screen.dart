import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../components/horizontal_calendar_widget.dart';
import '../components/select_seat_component.dart';
import '../components/time_slots_component.dart';
import 'check_out_movie_screen.dart';

class SelectSeatScreen extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String types;
  final String duration;
  final String rating;

  const SelectSeatScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.types,
    required this.duration,
    required this.rating,
  });

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text("Select Seats", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomPaint(
                    painter: CurveWidget(),
                    child: const SizedBox(height: 30, width: 200),
                  ),
                ),
                const SelectSeatComponent().paddingOnly(top: 12),
                16.height,
                Row(
                  children: [
                    const Expanded(child: Icon(Icons.event_seat, color: Colors.red)),
                    const Expanded(child: Text("Selected")),
                    const Expanded(child: Icon(Icons.event_seat, color: Colors.grey)),
                    const Expanded(child: Text("Booked")),
                    Expanded(child: Icon(Icons.event_seat, color: Colors.grey.withOpacity(0.5))),
                    const Expanded(child: Text("Available")),
                  ],
                ).paddingSymmetric(horizontal: 16),
                16.height,
                Container(
                  width: context.width(),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select date and time",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ).center(),
                      12.height,
                      const HorizontalCalendarWidget(),
                      12.height,
                      Container(
                        height: 160,
                        width: context.width(),
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: const Column(
                          children: [
                            TimeSlotsComponent(),
                          ],
                        ),
                      ).paddingOnly(top: 16)
                    ],
                  ).paddingOnly(top: 16),
                ),
              ],
            ).paddingOnly(top: 16),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(color: context.cardColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "\$310.70",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 210,
                    child: AppButton(
                      elevation: 0,
                      color: Colors.red,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.red),
                      ),
                      onTap: () async {
                        CheckOutMovieScreen(
                          image: widget.image,
                          title: widget.title,
                          subtitle: widget.subtitle,
                          rating: widget.rating,
                        ).launch(context);
                      },
                      child: Text("Confirm Seat", style: boldTextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// curve
class CurveWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        -size.height,
        size.width,
        size.height,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
