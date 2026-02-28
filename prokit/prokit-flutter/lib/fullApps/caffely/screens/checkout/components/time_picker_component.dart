import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../screen/pickup_at_time_screen.dart';

class TimePickerComponent extends StatefulWidget {
  const TimePickerComponent({super.key});

  @override
  _TimePickerModalState createState() => _TimePickerModalState();
}

class _TimePickerModalState extends State<TimePickerComponent> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 350,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              BottomSheetComponentText.setPickupTime,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(color: PickColor.greyColor),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: selectedTime,
                onDateTimeChanged: (DateTime newTime) {
                  setState(() {
                    selectedTime = newTime;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        backgroundColor: PickColor.brownColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PickupAtTimeScreen()),
                        );
                      },
                      child: const Text(BottomSheetComponentText.setTime, style: TextStyle(color: Colors.white)),
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
