import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/rounded_text_button.dart';
import '../../../utils/colors.dart';
import '../components/date_select_components/calendar.dart';
import '../components/date_select_components/guest_selection_bottom_sheet.dart';

class SelectDateScreen extends StatefulWidget {
  final int Hotelid;

  const SelectDateScreen({super.key, required this.Hotelid});

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = stayNestPrimaryColor;

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? Colors.white : Colors.black,
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Select Date'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (_) => CalendarCard(primaryColor: stayNestPrimaryColor),
            ),
            40.height,
            RoundedTextButton(
              backgroundColor: primaryColor,
              textColor: whitecolor,
              onPressed: () {
                showGuestSelectionBottomSheet(context, widget.Hotelid);
              },
              text: "Continue",
            ),
          ],
        ),
      ),
    );
  }
}
