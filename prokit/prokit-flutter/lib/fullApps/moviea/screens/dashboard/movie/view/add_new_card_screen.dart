import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height() * 0.45,
      child: Stack(fit: StackFit.expand, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Add New Card",
                style: boldTextStyle(size: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const Center(
              child: Text(
                "Add Your Card details hear ",
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              width: context.width(),
              decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ).paddingOnly(top: 10),
            ).paddingOnly(top: 16),
            Container(
              height: 50,
              width: context.width(),
              decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  labelStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ).paddingOnly(top: 10),
            ).paddingOnly(top: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    width: context.width(),
                    decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        labelStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ).paddingOnly(top: 10),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    width: context.width(),
                    decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        labelStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ).paddingOnly(top: 10),
                  ).paddingOnly(left: 16),
                ),
              ],
            ).paddingOnly(top: 16),
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
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onTap: () {
              finish(context);
            },
            child: Text("Add Card", style: boldTextStyle(color: white)),
          ),
        )
      ]),
    ).paddingAll(16);
  }
}
