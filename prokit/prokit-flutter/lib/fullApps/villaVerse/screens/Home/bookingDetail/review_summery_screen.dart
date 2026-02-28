import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../component/card_review_summary.dart';
import '../../../component/my_app_bar.dart';
import '../../../models/product_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import 'comfirm_payment_screen.dart';

class ReviewSummeryScreen extends StatefulWidget {
  const ReviewSummeryScreen({super.key});

  @override
  State<ReviewSummeryScreen> createState() => _ReviewSummeryScreenState();
}

class _ReviewSummeryScreenState extends State<ReviewSummeryScreen> {
  ProductModel data = favoriteProducts[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Review Summery'),
      body: ListView(
        children: [
          20.height,
          Card(
            elevation: 00,
            color: appStore.isDarkModeOn
                ? inputFillColorDart
                : inputFillColorlight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 120,
                              width: 120,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  data.imagePath,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 7,
                            right: 7,
                            child: Card(
                              color: inputFillColorlight,
                              elevation: 00,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.yellowAccent[400],
                                  ),
                                  Text(
                                    "4.7",
                                    style: TextStyle(color: darkColor),
                                  )
                                ],
                              ).paddingSymmetric(horizontal: 5),
                            ),
                          )
                        ],
                      ),
                      16.width,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.titleText,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              data.address,
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.price.substring(0, 3),
                              style: TextStyle(
                                  fontSize: 25, color: primaryBlueColor)),
                          Text(data.price.substring(3),
                              style: TextStyle(color: primaryBlueColor)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ).paddingSymmetric(horizontal: 12, vertical: 7),
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
            dividerColor: appStore.isDarkModeOn ? darkColor : lightColor,
          ),
          16.height,
          Card(
            elevation: 00,
            color: appStore.isDarkModeOn
                ? inputFillColorDart
                : inputFillColorlight,
            child: ListTile(
              onTap: () => finish(context),
              leading: Image.asset(googleIcon, height: 35, width: 35),
              title: Text("Google Pay"),
              trailing: Text(
                'Change',
                style: primaryTextStyle(color: primaryBlueColor),
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          16.height,
          AppButton(
            text: 'Continue',
            textColor: lightColor,
            color: primaryBlueColor,
            onTap: () => ComfirmPaymentScreen().launch(context),
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
