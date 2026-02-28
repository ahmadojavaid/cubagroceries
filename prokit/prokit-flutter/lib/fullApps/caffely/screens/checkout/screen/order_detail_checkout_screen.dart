import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../cancelorder/cancel_order_screen.dart';
import '../../choosedelivery/screen/choose_delivery_address_screen.dart';
import '../../choosedelivery/screen/choose_delivery_option_screen.dart';
import '../../driver_information/screen/search_driver_screen.dart';
import '../components/order_detail_component.dart';

class OrderDetailCheckoutScreen extends StatefulWidget {
  const OrderDetailCheckoutScreen({super.key});

  @override
  State<OrderDetailCheckoutScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<OrderDetailCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
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
                        const Text(DeliveryDetailText.orderedFrom),
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
                        const SizedBox(height: 10),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
                        const Text(DeliveryDetailText.toYourAddress),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChooseDeliveryAddressScreen()),
                          ),
                          child: Row(
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
                                  child: Icon(Icons.location_on_outlined, size: 20),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ChooseDeliveryAddressScreen()),
                                  ),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DeliveryDetailText.home,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        DeliveryDetailText.homeAddress,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        DeliveryDetailText.arrivedTime,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 20)
                            ],
                          ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Order Details",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                side: const BorderSide(color: Color.fromARGB(255, 105, 48, 27)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                              ),
                              child: const Text(
                                "+ Add more",
                                style: TextStyle(color: Color.fromARGB(255, 105, 48, 27)),
                              ),
                            )
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
                        const OrderDetailComponent(),
                        const Divider(color: PickColor.borderColor),
                        const Text("Notes"),
                        const Text(
                          "Less sugar please.",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Delivery", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const Divider(color: PickColor.borderColor),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChooseDeliveryOptionScreen()),
                              ),
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.network(Images.img_doordas, height: 40, width: 40),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "DoorDash Drive",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 20)
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PickColor.greyColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Detail",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Divider(color: PickColor.borderColor),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Grand Subtotal"),
                              Text("\$6.00"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service fee"),
                              Text("\$1.00"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery fee"),
                              Text("\$1.00"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discount"),
                              Text("- \$1.80"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("200 Points Used"),
                              Text("- \$2.00"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(color: PickColor.borderColor),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Payment"),
                              Text("\$4.20"),
                            ],
                          )
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: PickColor.greyColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Transaction Details",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Divider(color: PickColor.borderColor),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount"),
                              Text("\$4.20"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment Method"),
                              Text("Caffely Wallet"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Status"),
                              Container(
                                width: 40,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: PickColor.brownColor,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Paid",
                                  style: TextStyle(color: PickColor.whiteColor, fontSize: 10),
                                )),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date"),
                              Text("Dec 22, 2023"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Time"),
                              Text("09:41:20 AM"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order ID"),
                              Row(
                                children: [
                                  Text("ORD6980COF"),
                                  SizedBox(width: 10),
                                  Icon(Icons.copy, size: 15),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transaction ID "),
                              Row(
                                children: [Text("TRX9207PAY"), SizedBox(width: 10), Icon(Icons.copy, size: 15)],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Reference ID"),
                              Row(
                                children: [
                                  Text("REF5664RES"),
                                  SizedBox(width: 10),
                                  Icon(Icons.copy, size: 15),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            backgroundColor: PickColor.brownColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchDriverScreen()),
                            );
                          },
                          child: const Text(
                            "Track Order",
                            style: TextStyle(color: PickColor.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            elevation: 0,
                            side: const BorderSide(color: PickColor.brownColor),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CancelOrderHomeScreen()),
                            );
                          },
                          child: const Text("Cancel Order", style: TextStyle(color: PickColor.brownColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
