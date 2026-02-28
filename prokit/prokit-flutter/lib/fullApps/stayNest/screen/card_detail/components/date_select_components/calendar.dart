// ignore_for_file: file_names

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';

class CalendarCard extends StatefulWidget {
  final Color primaryColor;

  const CalendarCard({super.key, required this.primaryColor});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  void initState() {
    super.initState();
    checkInDate = DateTime.now();
    checkOutDate = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.range,
              selectedDayHighlightColor: widget.primaryColor,
              weekdayLabelTextStyle: TextStyle(color: Colors.grey.shade600),
              dayTextStyle: const TextStyle(fontSize: 14),
              controlsHeight: 50,
              selectedRangeDayTextStyle: const TextStyle(color: Colors.white),
              selectedRangeHighlightColor: widget.primaryColor,
              firstDate: DateTime.now(),
            ),
            value: [checkInDate, checkOutDate],
            onValueChanged: (List<DateTime?> dates) {
              setState(() {
                if (dates.isEmpty || dates[0] == null) {
                  checkInDate = null;
                  checkOutDate = null;
                  return;
                }

                checkInDate = dates[0];

                if (dates.length > 1 && dates[1] != null && dates[1]!.isAfter(dates[0]!)) {
                  checkOutDate = dates[1];
                } else {
                  checkOutDate = null;
                }
              });
            },
          ).paddingAll(8),
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDateSelector(
              title: "Check in",
              date: checkInDate ?? DateTime.now(),
              onTap: () {},
            ),
            const Icon(Icons.arrow_forward, color: stayNestPrimaryColor),
            buildDateSelector(
              title: "Check out",
              date: checkOutDate ?? (checkInDate != null ? checkInDate!.add(const Duration(days: 0)) : DateTime.now().add(const Duration(days: 1))),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateSelector({
    required String title,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${date.day}/${date.month}/${date.year}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  4.width,
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: stayNestPrimaryColor,
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
