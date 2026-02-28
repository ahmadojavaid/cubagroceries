import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/specialoffer/screen/specialofferlist_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/utils/colors.dart';

import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class SpecialOfferScreen extends StatelessWidget {
  const SpecialOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          SpecialOfferText.specialOffer,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: PickColor.brownColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        height: 170,
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 25.0, left: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            SpecialOfferText.off30,
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: PickColor.whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            SpecialOfferText.limitedTimeOffer,
                                            style: TextStyle(
                                              color: PickColor.whiteColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            SpecialOfferText.enjoyDiscount,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: PickColor.whiteColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.network(
                                    Images.img_coffeCup,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        SpecialOfferText.limitedOfferAnd30off,
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(SpecialOfferText.wakeupAndSmell),
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: 350,
                        decoration: const BoxDecoration(
                          color: PickColor.borderColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                SpecialOfferText.cuponCode,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.copy, size: 15),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: PickColor.borderColor,
                            width: 0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 20,
                                      color: PickColor.brownColor,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(SpecialOfferText.validUntil),
                                        Text(
                                          SpecialOfferText.validDate,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: PickColor.borderColor,
                                thickness: 1,
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.list_alt_outlined,
                                      size: 20,
                                      color: PickColor.brownColor,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(SpecialOfferText.minTransaction),
                                        Text(
                                          SpecialOfferText.minTransactionPrice,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SpecialOfferText.termsCondition,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.one),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  SpecialOfferText.oneDec,
                                  maxLines: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.two),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  SpecialOfferText.twoDec,
                                  maxLines: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.three),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  SpecialOfferText.threeDec,
                                  maxLines: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: BottomButton(
            btnText: "Claim Discount",
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SpecialOfferListScreen())),
            },
          ),
        )
      ]),
    );
  }
}
