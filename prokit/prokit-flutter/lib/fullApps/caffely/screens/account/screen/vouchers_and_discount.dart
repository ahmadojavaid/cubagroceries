import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../vouchersAvailble/components/use_button_component.dart';

class VouchersAndDiscount extends StatelessWidget {
  const VouchersAndDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vouchers & Discounts', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: PickColor.blackColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              height: 190,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpecialOfferText.limitedOfferAnd30off,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(SpecialOfferText.wakeupAndSmell, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, size: 20, color: PickColor.brownColor),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.validUntil, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.validDate,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.minTransactionPrice,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      UseButtonComponent(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 170,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpecialOfferText.earlyBird,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(SpecialOfferText.offOnAllCoffee, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.validUntil, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.validDate,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.minTransactionPrice,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      UseButtonComponent(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //second
            Container(
              height: 170,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpecialOfferText.rushHour,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(SpecialOfferText.getFreeUpgrade, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.validUntil, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.validDate,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.fistPrice,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      UseButtonComponent()
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //third
            Container(
              height: 170,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpecialOfferText.coffeAndcombo,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(SpecialOfferText.buyAndGetSliceCake, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.validUntil, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.dec29,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.fistPrice,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      UseButtonComponent()
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //forth
            Container(
              height: 170,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpecialOfferText.loyaltyPerks,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    SpecialOfferText.doublePoints,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, size: 20, color: PickColor.brownColor),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.validUntil, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.dec24,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.secondPrice,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      UseButtonComponent()
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //fifth
            Container(
              height: 170,
              width: 360,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SpecialOfferText.weekendRefuel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    SpecialOfferText.offOnAllDrinks,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.validUntil, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.dec28,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 20,
                            color: PickColor.brownColor,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(SpecialOfferText.minTransaction, style: TextStyle(fontSize: 10)),
                              Text(
                                SpecialOfferText.secondPrice,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: PickColor.borderColor,
                          thickness: 1,
                          width: 16,
                        ),
                      ),
                    ],
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
