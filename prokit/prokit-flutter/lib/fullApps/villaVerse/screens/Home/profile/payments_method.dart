import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/my_app_bar.dart';
import '../../../component/payment_method_selection.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import 'package:prokit_flutter/main.dart';

class PaymentsMethod extends StatefulWidget {
  const PaymentsMethod({super.key});

  @override
  State<PaymentsMethod> createState() => _PaymentsMethodState();
}

class _PaymentsMethodState extends State<PaymentsMethod> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Payment Method'),
      body: Stack(
        children: [
          ListView(
            children: [
              20.height,
              PaymentMethodSelection(
                imgPath: googleIcon,
                text: "Google Pay",
                borderColor: selectedIndex == 0 ? primaryBlueColor : null,
                voidCallBack: () =>
                    setState(
                          () {
                        selectedIndex = 0;
                      },
                    ),
              ),
              16.height,
              PaymentMethodSelection(
                  imgPath: appleIcon,
                  text: "Apple Pay",
                  borderColor: selectedIndex == 1 ? primaryBlueColor : null,
                  voidCallBack: () =>
                      setState(
                            () {
                          selectedIndex = 1;
                        },
                      ),
                  color: appStore.isDarkModeOn ? lightColor : darkColor),
              16.height,
              PaymentMethodSelection(
                imgPath: masterCard,
                text: "**** **** 4854",
                borderColor: selectedIndex == 2 ? primaryBlueColor : null,
                voidCallBack: () =>
                    setState(
                          () {
                        selectedIndex = 2;
                      },
                    ),
              ),
              16.height,
              PaymentMethodSelection(
                imgPath: masterCard,
                text: "**** **** 5687",
                borderColor: selectedIndex == 3 ? primaryBlueColor : null,
                voidCallBack: () =>
                    setState(
                          () {
                        selectedIndex = 3;
                      },
                    ),
              ),
              16.height,
              PaymentMethodSelection(
                imgPath: masterCard,
                text: "**** **** 9824",
                borderColor: selectedIndex == 4 ? primaryBlueColor : null,
                voidCallBack: () =>
                    setState(
                          () {
                        selectedIndex = 4;
                      },
                    ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AppButton(
              text: 'Add New Card',
              textColor: lightColor,
              color: primaryBlueColor,
              onTap: () {},
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ).paddingAll(16),
          ),
        ],
      )
    );
  }
}