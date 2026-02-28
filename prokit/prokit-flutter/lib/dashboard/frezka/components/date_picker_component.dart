import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';
import 'package:prokit_flutter/main.dart'; // Needed for appStore.isDarkModeOn

class DatePickerContainer extends StatefulWidget {
  const DatePickerContainer({super.key});

  @override
  State<DatePickerContainer> createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            txtWidget(
              selectedDate == null
                  ? "Select Date"
                  : DateFormat("dd MMM yyyy").format(selectedDate!),
              12,
              FontWeight.w500,
              frezlaAppColor.dateTxtColor,
            ),
            iconWidget(frezkaAppImages.downArrow, 16, frezlaAppColor.dateTxtColor),
          ],
        ),
      ),
    );
  }

 Future<void> _pickDate(BuildContext context) async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      final isDark = appStore.isDarkModeOn;

      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: isDark
              ? ColorScheme.dark(
                  primary: frezlaAppColor.btnColor,
                  onPrimary: frezlaAppColor.black,
                  surface: frezlaAppColor.bgColor,
                  onSurface: frezlaAppColor.black,
                )
              : ColorScheme.light(
                  primary: frezlaAppColor.btnColor,
                  onPrimary: frezlaAppColor.white,
                  surface: frezlaAppColor.white,
                  onSurface: frezlaAppColor.black,
                ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: frezlaAppColor.btnColor, // Confirm/Cancel button color
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          dialogBackgroundColor:
              isDark ? frezlaAppColor.bgColor : frezlaAppColor.white,
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    setState(() {
      selectedDate = picked;
    });
  }
}

}
