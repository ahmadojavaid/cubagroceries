import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../component/card_review_summary.dart';
import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';
import '../homeScreenActions/components/bottom_navigation.dart';

class EReceiptScreen extends StatefulWidget {
  const EReceiptScreen({super.key});

  @override
  State<EReceiptScreen> createState() => _EReceiptScreenState();
}

class _EReceiptScreenState extends State<EReceiptScreen> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'E-Receipt'),
      body: ListView(
        children: [
          16.height,
          SizedBox(
            height: 150,
            child: SfBarcodeGenerator(
              value: '4006381333931',
              symbology: EAN13(),
              showValue: true,
            ),
          ).paddingSymmetric(horizontal: 5),
          16.height,
          CardReviewSummary(
            lable1: "Date",
            text1: "Dec 23-Dec 27, 2024",
            lable2: "Check in",
            text2: "December 23, 2024",
            lable3: "Check out",
            text3: "December 27, 2024",
          ),
          16.height,
          CardReviewSummary(
            lable1: "Amount (5 days)",
            text1: "\$ 145.00",
            lable2: "Tax",
            text2: "\$ 5.00",
            lable3: "Total",
            text3: "\$ 150.00",
            dividerColor: hintTextColor,
          ),
          16.height,
          CardReviewSummary(
            lable1: "Name",
            text1: "Andrew Ainsley",
            lable2: "Phone Number",
            text2: "+1 111 458 154 641",
            lable3: "Transaction ID",
            text3: "45452148941",
            copy: 'copy',
            dividerColor: hintTextColor,
          ),
          16.height,
          Card(
            elevation: 00,
            color: appStore.isDarkModeOn
                ? inputFillColorDart
                : inputFillColorlight,
            child: ListTile(
              title: Text('Status',
                  style: secondaryTextStyle(color: hintTextColor)),
              trailing: Card(
                elevation: 00,
                color: appStore.isDarkModeOn
                    ? inputFillColorDart
                    : inputFillColorlight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: primaryBlueColor),
                ),
                child: Text(
                  "Paid",
                  style: secondaryTextStyle(color: primaryBlueColor),
                ).paddingSymmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          16.height,
          AppButton(
            text: 'Rating',
            textColor: lightColor,
            color: primaryBlueColor,
            onTap: ratingSheet,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ).paddingSymmetric(horizontal: 16),
          16.height
        ],
      ),
    );
  }

  void ratingSheet() {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: 500,
            width: context.width(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27),
                topRight: Radius.circular(27),
              ),
              color: appStore.isDarkModeOn
                  ? inputFillColorDart
                  : inputFillColorlight,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.height,
                  Divider(color: Colors.grey, height: 20)
                      .paddingSymmetric(horizontal: context.width() * .45),
                  16.height,
                  Center(
                    child: Text("Leave a Review",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  16.height,
                  Divider(color: Theme.of(context).scaffoldBackgroundColor)
                      .paddingSymmetric(horizontal: 16),
                  16.height,
                  Text(
                    "How was your experience with Modernica Apartments?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ratingIcon(
                        () => setModalState(() {
                          rating = 1;
                        }),
                        rating >= 1 ? Icons.star : Icons.star_border,
                      ),
                      ratingIcon(
                        () => setModalState(() {
                          rating = 2;
                        }),
                        rating >= 2 ? Icons.star : Icons.star_border,
                      ),
                      ratingIcon(
                        () => setModalState(() {
                          rating = 3;
                        }),
                        rating >= 3 ? Icons.star : Icons.star_border,
                      ),
                      ratingIcon(
                        () => setModalState(() {
                          rating = 4;
                        }),
                        rating >= 4 ? Icons.star : Icons.star_border,
                      ),
                      ratingIcon(
                        () => setModalState(() {
                          rating = 5;
                        }),
                        rating == 5 ? Icons.star : Icons.star_border,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  Divider(color: context.cardColor)
                      .paddingSymmetric(horizontal: 16),
                  16.height,
                  Text(
                    'Write your review',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).paddingOnly(left: 16),
                  16.height,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: appStore.isDarkModeOn ? darkColor : lightColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: appStore.isDarkModeOn ? darkColor : lightColor,
                        border: InputBorder.none,
                        hintText: 'Your review here...',
                        hintStyle: TextStyle(color: hintTextColor),
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  Divider(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          elevation: 0,
                          text: 'Maybe Later',
                          textColor: appStore.isDarkModeOn
                              ? lightColor
                              : primaryBlueColor,
                          color:
                              appStore.isDarkModeOn ? hintTextColor : blueLight,
                          width: context.width() / 2.5,
                          onTap: () => finish(context),
                          shapeBorder:
                              RoundedRectangleBorder(borderRadius: radius(20)),
                        ),
                      ),
                      16.width,
                      Expanded(
                        child: AppButton(
                          elevation: 0,
                          text: 'Submit',
                          color: primaryBlueColor,
                          textColor: lightColor,
                          width: context.width() / 2.5,
                          onTap: () {
                            toast('Review Submited');
                            BottomNavigation().launch(context);
                          },
                          shapeBorder:
                              RoundedRectangleBorder(borderRadius: radius(20)),
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 16, left: 16, right: 16),
                  16.height
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget ratingIcon(VoidCallback voidCallBack, IconData icon) {
    return GestureDetector(
      onTap: voidCallBack,
      child: Icon(icon, color: primaryBlueColor, size: 30),
    );
  }
}
