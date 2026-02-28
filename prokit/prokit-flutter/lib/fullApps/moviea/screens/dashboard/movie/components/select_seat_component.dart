import 'package:flutter/material.dart';

class SelectSeatComponent extends StatefulWidget {
  const SelectSeatComponent({super.key});

  @override
  State<SelectSeatComponent> createState() => _SelectSeatComponentState();
}

class _SelectSeatComponentState extends State<SelectSeatComponent> {
  List<List<bool>> seatStates = [
    [false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, false, false]
  ];

  List<List<bool>> disabledSeats = [
    [false, false, false, false, false, false],
    [false, false, false, false, true, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, true, true, false, false, false, false],
    [false, false, true, true, false, false, false, false],
    [false, false, false, false, false, false, false, false],
    [false, false, false, false, true, true],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(seatStates.length, (index) {
        return buildRow(seatStates[index], disabledSeats[index]);
      }),
    );
  }

  Widget buildRow(List<bool> seats, List<bool> disabled) {
    List<Widget> seatWidgets = [];
    int midIndex = seats.length ~/ 2;

    for (int i = 0; i < seats.length; i++) {
      seatWidgets.add(buildSeat(seats[i], disabled[i], (bool newState) {
        setState(() {
          seats[i] = newState;
        });
      }));
      if (i == midIndex - 1) {
        seatWidgets.add(const SizedBox(width: 20));
      } else if (i < seats.length - 1) {
        seatWidgets.add(const SizedBox(width: 5));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seatWidgets,
    );
  }

  Widget buildSeat(bool isOccupied, bool isDisabled, Function(bool) onTap) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          onTap(!isOccupied);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.event_seat,
            color: isDisabled ? Colors.grey.shade500 : (isOccupied ? Colors.red : Colors.grey.withOpacity(0.6)),
            size: 25,
          ),
        ),
      ),
    );
  }
}
