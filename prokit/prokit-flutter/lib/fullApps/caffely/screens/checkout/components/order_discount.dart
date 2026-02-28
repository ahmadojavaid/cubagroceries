import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../vouchersAvailble/screen/vouchers_available_screen.dart';

class OrderDiscount extends StatelessWidget {
  const OrderDiscount({super.key});

  get selectedVoucher => null;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            GestureDetector(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VouchersAvailableScreen())),
              },
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
                    child: const Center(
                      child: Icon(Icons.local_offer_outlined, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  selectedVoucher != null
                      ? SizedBox(
                          width: 100,
                          height: 30,
                          child: Container(
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
                          ),
                        )
                      : const Expanded(
                          flex: 3,
                          child: Column(
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
                        ),
                  const Icon(Icons.arrow_forward_ios, size: 20)
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
                        "100 popints equals \$1.00",
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
                          Icons.toggle_off_outlined,
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
    );
  }
}
