// ignore_for_file: unnecessary_null_comparison, unused_local_variable, deprecated_member_use

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../main.dart';
import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';
import 'book_reale_estate_information_screen.dart';
import 'bookingComponents/title_text.dart';

class BookRealEstateDateSelection extends StatefulWidget {
  const BookRealEstateDateSelection({super.key});

  @override
  State<BookRealEstateDateSelection> createState() =>
      _BookRealEstateDateSelectionState();
}

class _BookRealEstateDateSelectionState
    extends State<BookRealEstateDateSelection> {
  DateTime? checkInDate = DateTime.now();
  DateTime? checkOutDate = DateTime.now();

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary:
                        primaryBlueColor, // header background color & selected date
                    onPrimary: lightColor, // text color on selected date
                    onSurface: lightColor, // default text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          primaryBlueColor, // button text color (OK, Cancel)
                    ),
                  ),
                )
              : Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary:
                        primaryBlueColor, // header background color & selected date
                    onPrimary: lightColor, // text color on selected date
                    onSurface: darkColor, // default text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          primaryBlueColor, // button text color (OK, Cancel)
                    ),
                  ),
                ),
          child: child!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Book Real Estate'),
      body: SafeArea(
        child: ListView(
          children: [
            16.height,
            TitleText(text: "Select Data"),
            16.height,
            Card(
              elevation: 0,
              color: appStore.isDarkModeOn
                  ? inputFillColorDart
                  : inputFillColorlight,
              child: CalendarDatePicker2(
                value: [checkInDate, checkOutDate],
                onValueChanged: (dates) {
                  setState(() {
                    if (dates.isEmpty || dates[0] == null) {
                      checkInDate = null;
                      checkOutDate = DateTime.now();
                      return;
                    }

                    checkInDate = dates[0];

                    if (dates.length > 1 &&
                        dates[1] != null &&
                        dates[1].isAfter(dates[0])) {
                      checkOutDate = dates[1];
                    } else {
                      checkOutDate = null;
                    }
                  });
                },
                config: CalendarDatePicker2Config(
                  firstDate: DateTime.now(),
                  daySplashColor: Colors.transparent,
                  currentDate: DateTime.now(),
                  calendarType: CalendarDatePicker2Type.range,
                  selectedDayHighlightColor: primaryBlueColor,
                  selectedDayTextStyle: TextStyle(color: lightColor),
                  controlsTextStyle: TextStyle(
                    color: appStore.isDarkModeOn ? lightColor : darkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  centerAlignModePicker: true,
                  selectedRangeHighlightColor: appStore.isDarkModeOn
                      ? darkColor.withOpacity(0.4)
                      : primaryBlueColor.withOpacity(.4),
                  disableModePicker: true,
                  firstDayOfWeek: 1, // Monday
                ),
              ),
            ).paddingSymmetric(horizontal: 16),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateField(
                    'Check in', checkInDate.toString().split(' ')[0]),
                16.width,
                _buildDateField(
                  'Check out',
                  checkOutDate == null
                      ? checkInDate.toString().split(' ')[0]
                      : checkOutDate.toString().split(' ')[0],
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            16.height,
            Text(
              'Note to Owner (optional)',
              style: TextStyle(
                fontSize: 16,
              ),
            ).paddingSymmetric(horizontal: 16),
            16.height,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: appStore.isDarkModeOn
                    ? inputFillColorDart
                    : inputFillColorlight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Notes',
                  hintStyle: TextStyle(color: hintTextColor),
                ),
              ),
            ).paddingSymmetric(horizontal: 16),
            16.height,
            AppButton(
              text: 'Continue',
              color: primaryBlueColor,
              textStyle: boldTextStyle(color: Colors.white),
              onTap: () {
                hideKeyboard(context);
                BookRealeEstateInformationScreen().launch(context);
              },
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String title, String dateText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: primaryTextStyle(),
        ),
        8.height,
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: appStore.isDarkModeOn
                ? inputFillColorDart
                : inputFillColorlight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateText),
                GestureDetector(
                  onTap: () {
                    hideKeyboard(context);
                    _showDatePicker(context);
                  },
                  child: Icon(Icons.calendar_today,
                      color: hintTextColor, size: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
