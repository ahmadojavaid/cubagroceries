import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../choosedelivery/screen/choose_delivery_address_screen.dart';
import '../../choosedelivery/screen/choose_delivery_option_screen.dart';
import '../../paymentmethods/screen/payment_method_screen.dart';
import '../../vouchersAvailble/screen/vouchers_available_screen.dart';
import '../components/order_detail_component.dart';
import '../components/payment_detail_component.dart';
import 'order_detail_checkout_screen.dart';

class DeliverDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedVoucher;
  final Map<String, dynamic>? selectedDelivery;
  final Map<String, dynamic>? selectedPayment;

  const DeliverDetailScreen({super.key, this.selectedVoucher, this.selectedDelivery, this.selectedPayment});

  @override
  State<DeliverDetailScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<DeliverDetailScreen> {
  Map<String, dynamic>? selectedVoucher;
  Map<String, dynamic>? selectedDelivery;
  Map<String, dynamic>? selectedPayment;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    selectedVoucher = widget.selectedVoucher; // Initialize selectedVoucher from passed data
    selectedDelivery = widget.selectedDelivery;
    selectedPayment = widget.selectedPayment;
  }

  Future<void> _selectVoucher() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VouchersAvailableScreen()),
    );
    if (result != null) {
      setState(() {
        selectedVoucher = result;
      });
    }
  }

  Future<void> _selectedDelivery() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseDeliveryOptionScreen()),
    );
    if (result != null) {
      setState(() {
        selectedDelivery = result;
      });
    }
  }

  Future<void> _selectedPayment() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentMethodScreen()),
    );
    if (result != null) {
      setState(() {
        selectedPayment = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
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
                            child: const Text("+ Add more", style: TextStyle(color: Color.fromARGB(255, 105, 48, 27))),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Method",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Divider(color: PickColor.borderColor),
                      GestureDetector(
                        onTap: _selectedDelivery,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: selectedDelivery != null
                                    ? Image.network(
                                        Images.img_doordas, //TODO: use image variables
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.directions_bike, size: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedDelivery != null ? selectedDelivery!['name'] : "Choose Delivery",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 20),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order Discount",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Divider(color: PickColor.borderColor),
                      GestureDetector(
                        onTap: _selectVoucher,
                        child: Row(
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
                                selectedVoucher != null
                                    ? Container(
                                        width: 100,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: PickColor.brownColor,
                                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${selectedVoucher!["code"]}",
                                            style: const TextStyle(color: PickColor.whiteColor),
                                          ),
                                        ),
                                      )
                                    : const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Use Vouchers",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "Save orders with promos",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
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
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: isActive,
                              onChanged: (value) {
                                setState(() {
                                  isActive = !isActive;
                                });
                              },
                              activeTrackColor: PickColor.brownColor,
                              activeColor: PickColor.whiteColor,
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Method",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Divider(color: PickColor.borderColor),
                      GestureDetector(
                        onTap: _selectedPayment,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: selectedPayment != null
                                    ? const Icon(
                                        Icons.wallet,
                                        color: PickColor.brownColor,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.credit_card_outlined,
                                        size: 20,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedPayment != null && selectedPayment!.containsKey('text') ? selectedPayment!['text']! : "Choose Payment",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    selectedPayment != null && selectedPayment!.containsKey('price') ? selectedPayment!['price']! : "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: PickColor.brownColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const PaymentDetailComponent(),
              const SizedBox(height: 70),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 2.0,
          right: 2.0,
          child: BottomButton(
            btnText: "Place Order",
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailCheckoutScreen())),
            },
          ),
        )
      ]),
    );
  }
}
