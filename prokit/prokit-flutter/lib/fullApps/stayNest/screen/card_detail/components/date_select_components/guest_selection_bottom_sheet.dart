import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../components/rounded_text_button.dart';
import '../../../../utils/colors.dart';
import '../../view/confirm_pay_screen.dart';
import 'guest_counter.dart';

void showGuestSelectionBottomSheet(BuildContext context, int id) {
  int adultCount = 2;
  int childrenCount = 2;
  int infantCount = 1;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  16.height,
                  const Text(
                    'Select Guest',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  16.height,
                  GuestCounter(
                    title: 'Adults',
                    subtitle: 'Ages 14 or above',
                    count: adultCount,
                    onIncrement: () => setState(() => adultCount++),
                    onDecrement: () {
                      if (adultCount > 1) setState(() => adultCount--);
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
                  GuestCounter(
                    title: 'Children',
                    subtitle: 'Ages 2–13',
                    count: childrenCount,
                    onIncrement: () => setState(() => childrenCount++),
                    onDecrement: () {
                      if (childrenCount > 0) setState(() => childrenCount--);
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
                  GuestCounter(
                    title: 'Infants',
                    subtitle: 'Under 2',
                    count: infantCount,
                    onIncrement: () => setState(() => infantCount++),
                    onDecrement: () {
                      if (infantCount > 0) setState(() => infantCount--);
                    },
                  ),
                  20.height,
                  RoundedTextButton(
                    backgroundColor: stayNestPrimaryColor,
                    textColor: whitecolor,
                    onPressed: () {
                      Navigator.pop(context);
                      ConfirmPayScreen(
                        hotelid: id,
                        adults: adultCount,
                        children: childrenCount,
                        totaldays: 1,
                      ).launch(context);
                    },
                    text: "Next",
                  ),
                  30.height,
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
