import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalCalendarWidget extends StatefulWidget {
  const HorizontalCalendarWidget({super.key});

  @override
  _HorizontalCalendarWidgetState createState() => _HorizontalCalendarWidgetState();
}

class _HorizontalCalendarWidgetState extends State<HorizontalCalendarWidget> {
  DateTime selectedDate = DateTime.now();
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();

    startDate = DateTime(selectedDate.year, selectedDate.month, 1);
    // Set the end date to the last day of the current month
    endDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
  }

  void _goToPreviousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
      startDate = DateTime(selectedDate.year, selectedDate.month, 1);
      endDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    });
  }

  void _goToNextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
      startDate = DateTime(selectedDate.year, selectedDate.month, 1);
      endDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _goToPreviousMonth,
                icon: const Icon(Icons.navigate_before),
              ),
              Text(
                DateFormat.yMMMM().format(selectedDate),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: _goToNextMonth,
                icon: const Icon(Icons.navigate_next),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: endDate.difference(startDate).inDays + 1,
              itemBuilder: (context, index) {
                DateTime date = startDate.add(Duration(days: index));
                bool isSelected = date.day == selectedDate.day && date.month == selectedDate.month && date.year == selectedDate.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.white,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.E().format(date), // Day of the week
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          date.day.toString(), // Day of the month
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
