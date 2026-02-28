import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../components/order_detail_component.dart';
import '../components/view_order_component.dart';

class PickupDetailScreen extends StatefulWidget {
  const PickupDetailScreen({super.key});

  @override
  State<PickupDetailScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<PickupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.greyColor),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: PickColor.whiteColor,
                            border: Border.all(color: PickColor.greyColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.access_time, size: 20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DeliveryDetailText.pickUpAtTime,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text(
                                DeliveryDetailText.pickUpAtDate,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 20)
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: PickColor.greyColor),
                    const SizedBox(height: 10),
                    const Text(CheckOutText.takeOrderAt),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: PickColor.whiteColor,
                            border: Border.all(color: PickColor.greyColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.store, size: 20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                CafeDetailText.caffelyAstoriaAromas,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                CafeDescriptionText.addressDetail,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                CheckOutText.fromLocation,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: PickColor.greyColor),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Order Details",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: const BorderSide(
                              color: Color.fromARGB(255, 105, 48, 27),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          ),
                          child: const Text(
                            "+ Add more",
                            style: TextStyle(color: Color.fromARGB(255, 105, 48, 27)),
                          ),
                        )
                      ],
                    ),
                    const Divider(color: PickColor.greyColor),
                    const SizedBox(height: 10),
                    const OrderDetailComponent(),
                    const Divider(color: PickColor.greyColor)
                  ],
                ),
              ),
            ),
            const ViewOrderComponent()
          ],
        ),
      ),
    );
  }
}
