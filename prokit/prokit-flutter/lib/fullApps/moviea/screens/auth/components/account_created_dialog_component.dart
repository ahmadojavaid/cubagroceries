import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../dashboard/view/dashboard_screen.dart';

class AccountCreatedDialogComponent extends StatefulWidget {
  const AccountCreatedDialogComponent({super.key});

  @override
  State<AccountCreatedDialogComponent> createState() => _AccountCreatedDialogComponentState();
}

class _AccountCreatedDialogComponentState extends State<AccountCreatedDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: context.height() * 0.4,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                      child: const Center(
                        child: Icon(Icons.check_rounded, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                20.height,
                const Text(
                  "Account Created Successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                8.height,
                const Text(
                  "Your account created successfully. Listen your favourite music ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AppButton(
                elevation: 0,
                width: context.width(),
                color: Colors.red,
                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                onTap: () {
                  finish(context);

                  const DashboardScreen().launch(
                    context,
                    pageRouteAnimation: PageRouteAnimation.Fade,
                  );
                },
                child: Text("Go to Home", style: boldTextStyle(color: white)),
              ),
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
