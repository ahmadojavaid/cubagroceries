import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/bookingDetail/review_summery_screen.dart';
import 'package:prokit_flutter/main.dart';

import '../../../component/my_app_bar.dart';
import '../../../component/payment_method_selection.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import 'add_new_card.dart' show AddNewCard;
import 'bookingComponents/title_text.dart';

class BookRealEstatePaymentSelection extends StatefulWidget {
  const BookRealEstatePaymentSelection({super.key});

  @override
  State<BookRealEstatePaymentSelection> createState() => _BookRealEstatePaymentSelectionState();
}

class _BookRealEstatePaymentSelectionState extends State<BookRealEstatePaymentSelection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Book Real Estate'),
      body: ListView(
        children: [
          16.height,
          TitleText(text: "Select the payment method you want to use"),
          16.height,
          PaymentMethodSelection(
              imgPath: googleIcon,
              text: "Google Pay",
              borderColor: selectedIndex == 0 ? primaryBlueColor : null,
              voidCallBack: () => setState(() {
                    selectedIndex = 0;
                  })),
          16.height,
          PaymentMethodSelection(
              imgPath: appleIcon,
              text: "Apple Pay",
              borderColor: selectedIndex == 1 ? primaryBlueColor : null,
              voidCallBack: () => setState(() {
                    selectedIndex = 1;
                  }),
              color: appStore.isDarkModeOn ? lightColor : darkColor),
          16.height,
          PaymentMethodSelection(
              imgPath: masterCard,
              text: "**** **** 4854",
              borderColor: selectedIndex == 2 ? primaryBlueColor : null,
              voidCallBack: () => setState(() {
                    selectedIndex = 2;
                  })),
          16.height,
          PaymentMethodSelection(
              imgPath: masterCard,
              text: "**** **** 5687",
              borderColor: selectedIndex == 3 ? primaryBlueColor : null,
              voidCallBack: () => setState(() {
                    selectedIndex = 3;
                  })),
          16.height,
          PaymentMethodSelection(
              imgPath: masterCard,
              text: "**** **** 9824",
              borderColor: selectedIndex == 4 ? primaryBlueColor : null,
              voidCallBack: () => setState(() {
                    selectedIndex = 4;
                  })),
          16.height,
          AppButton(
            elevation: 0,
            text: 'Add New Card',
            color: appStore.isDarkModeOn ? hintTextColor : blueLight,
            textStyle: boldTextStyle(color: appStore.isDarkModeOn ? lightColor : primaryBlueColor),
            width: context.width(),
            onTap: () => AddNewCard().launch(
              context,
            ),
            shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
          ).paddingSymmetric(horizontal: 16),
          16.height,
          AppButton(
            text: 'Continue',
            textColor: lightColor,
            color: primaryBlueColor,
            onTap: () => ReviewSummeryScreen().launch(
              context,
            ),
            shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ).paddingSymmetric(horizontal: 16)
        ],
      ),
    );
  }
}
