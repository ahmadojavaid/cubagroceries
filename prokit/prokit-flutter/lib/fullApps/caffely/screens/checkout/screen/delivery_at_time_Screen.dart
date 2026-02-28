import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../choosedelivery/screen/choose_delivery_address_screen.dart';
import '../../home/screen/home_page_screen.dart';
import '../components/order_detail_component.dart';
import 'order_detail_pick_at_time_screen.dart';

class DeliveryAtTimeScreen extends StatefulWidget {
  const DeliveryAtTimeScreen({super.key});

  @override
  State<DeliveryAtTimeScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<DeliveryAtTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.network(Images.img_doordas, height: 40, width: 40),
                              const SizedBox(width: 10),
                              const Text(
                                "DoorDash Drive",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 20)
                        ],
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Discount",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(color: PickColor.borderColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Icon(Icons.local_offer_outlined, size: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: PickColor.brownColor,
                                border: Border.all(color: PickColor.borderColor),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(
                                  child: Text(
                                "XGZ9V2  x",
                                style: TextStyle(color: PickColor.whiteColor),
                              )),
                            )
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 20)
                      ],
                    ),
                    const Divider(color: PickColor.borderColor),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.control_point_sharp, size: 20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "200 Points",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "100 points equals \$1.00",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.toggle_on,
                                  size: 40,
                                  color: PickColor.brownColor,
                                ),
                              ],
                            )
                          ],
                        )
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
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Divider(color: PickColor.borderColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.wallet,
                              size: 35,
                              color: PickColor.brownColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "My Wallet",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("\$948.50"),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        )
                      ],
                    )
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomButton(
          btnText: "Place Order",
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.all(20.0),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        Images.img_lottie4, //TODO: lottie variable
                        height: 200,
                        reverse: true,
                        repeat: true,
                      ),
                      const SizedBox(height: 16),
                      const Text(DeliveryDetailText.orderSuccess, style: TextStyle(fontSize: 30)),
                      const SizedBox(height: 13),
                      const Text(DeliveryDetailText.orderSuccessQuotes),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 24.0,
                              ),
                              backgroundColor: PickColor.brownColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OrderDetailPickAtTimeScreen()),
                              );
                            },
                            child: const Text(
                              DeliveryDetailText.viewMyOrder,
                              style: TextStyle(color: PickColor.whiteColor),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 24.0,
                              ),
                              backgroundColor: PickColor.brownColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePageScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              DeliveryDetailText.backToHome,
                              style: TextStyle(color: PickColor.whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
