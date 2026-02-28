import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../paymentmethods/screen/payment_method_screen.dart';
import '../../vouchersAvailble/screen/vouchers_available_screen.dart';
import '../components/choose_pickup_time_component.dart';
import '../components/order_detail_list_component.dart';
import '../components/payment_detail_component.dart';
import 'order_detail_pick_at_time_screen.dart';

class PickupScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedVoucher;
  final Map<String, dynamic>? selectedPayment;

  const PickupScreen({super.key, this.selectedVoucher, this.selectedPayment});

  @override
  State<PickupScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<PickupScreen> {
  Map<String, dynamic>? selectedVoucher;
  Map<String, dynamic>? selectedPayment;

  bool isActive = true;

  @override
  void initState() {
    super.initState();
    selectedVoucher = widget.selectedVoucher;
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
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              const ChoosePickUpTimeComponent(),
              const SizedBox(height: 20),
              const OrderDetailListComponent(),
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
                                        size: 20,
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
            btnText: 'Place Order',
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailPickAtTimeScreen())),
            },
          ),
        )
      ]),
    );
  }
}
