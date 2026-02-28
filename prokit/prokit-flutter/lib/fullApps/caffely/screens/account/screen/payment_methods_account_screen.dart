import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/add_new_payment_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/images.dart';
import '../model/payment_method_account_model.dart';

class PaymentMethodAccountScreen extends StatefulWidget {
  const PaymentMethodAccountScreen({super.key});

  @override
  State<PaymentMethodAccountScreen> createState() => _PaymentMethodAccountScreenState();
}

List<PaymentMethodAccountModel> paymentDetailList = paymentDetail();

class _PaymentMethodAccountScreenState extends State<PaymentMethodAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Methods',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewPaymentScreen()));
                  },
                  icon: Icon(Icons.add)))
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              ListView.builder(
                itemCount: paymentDetailList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final payment = paymentDetailList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border.all(color: PickColor.borderColor), borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              index == 3
                                  ? ClipOval(
                                      child: Image.network(
                                        Images.img_mastercardLogo,
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.network(
                                      payment.icon,
                                      height: 50,
                                    ),
                              const SizedBox(width: 18),
                              Text(
                                payment.name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Text(
                            "Connected",
                            style: TextStyle(
                              color: PickColor.brownColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(bottom: 16.0, left: 16.0, right: 16.0, child: BottomButton(btnText: "Ok", onTap: () => {Navigator.pop(context)}))
      ]),
    );
  }
}
