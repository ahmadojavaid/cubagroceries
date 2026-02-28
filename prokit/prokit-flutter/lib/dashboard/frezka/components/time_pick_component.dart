import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class TimePickerField extends StatefulWidget {
  const TimePickerField({super.key});

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  String? selectedTime;
  void _openTimeBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: frezlaAppColor.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TimeSlotBottomSheet(selectedTime: selectedTime),
    );
    if (result != null) {
      setState(() {
        selectedTime = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openTimeBottomSheet(context),
      child: Container(
        width: 181,
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: frezlaAppColor.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: frezlaAppColor.black.withAlpha((0.05 * 255).toInt()),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: txtWidget(
                selectedTime ?? 'Select Time',
                12,
                FontWeight.w500,
                frezlaAppColor.dateTxtColor,
              ),
            ),
            iconWidget(
                frezkaAppImages.downArrow, 16, frezlaAppColor.dateTxtColor),
          ],
        ),
      ),
    );
  }
}

class TimeSlotBottomSheet extends StatelessWidget {
  final String? selectedTime;

  const TimeSlotBottomSheet({super.key, this.selectedTime});

  List<String> _generateTimeSlots() {
    List<String> slots = [];
    DateTime start = DateTime(0, 1, 1, 9, 0);
    DateTime end = DateTime(0, 1, 1, 17, 30);

    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      slots.add(DateFormat.jm().format(start));
      start = start.add(const Duration(minutes: 15));
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = _generateTimeSlots();
    final morningSlots = timeSlots.where((t) => t.contains("AM")).toList();
    final afternoonSlots = timeSlots.where((t) => t.contains("PM")).toList();
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (_, controller) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          controller: controller,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Available Slots',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (morningSlots.isNotEmpty) ...[
              const Text(
                'Morning',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildGrid(context, morningSlots),
            ],
            if (afternoonSlots.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Afternoon',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildGrid(context, afternoonSlots),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<String> slots) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((time) {
        final isSelected = time == selectedTime;

        return GestureDetector(
          onTap: () => Navigator.pop(context, time),
          child: Container(
            width: 73,
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? frezlaAppColor.selectedTime
                  : frezlaAppColor.timePickerContainer,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: frezlaAppColor.white.withAlpha((0.03 * 255).toInt()),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
              border: isSelected
                  ? Border.all(color: frezlaAppColor.deepPurple)
                  : Border.all(color: frezlaAppColor.transparent),
            ),
            alignment: Alignment.center,
            child: Marquee(
              direction: Axis.horizontal,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? frezlaAppColor.deepPurple
                      : frezlaAppColor.black,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
