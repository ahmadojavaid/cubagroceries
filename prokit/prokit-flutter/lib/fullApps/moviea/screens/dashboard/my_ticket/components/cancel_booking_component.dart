import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/common_base.dart';

class CancelBookingComponent extends StatefulWidget {
  const CancelBookingComponent({super.key});

  @override
  State<CancelBookingComponent> createState() => _CancelBookingComponentState();
}

class _CancelBookingComponentState extends State<CancelBookingComponent> {
  ScrollController scrollController = ScrollController();
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: SizedBox(
        width: double.infinity,
        height: context.height() * 0.65,
        child: Stack(fit: StackFit.expand, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Cancel Booking",
                  style: boldTextStyle(size: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              8.height,
              Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please select the reason for cancellation",
                      style: secondaryTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ).expand(),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              SizedBox(
                height: 26,
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.red,
                      visualDensity: VisualDensity.compact,
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                    const Text("I have better deal"),
                  ],
                ),
              ),
              SizedBox(
                height: 26,
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.red,
                      value: 2,
                      visualDensity: VisualDensity.compact,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                    const Text("Some other work, can't come"),
                  ],
                ),
              ).paddingOnly(top: 5),
              SizedBox(
                height: 26,
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.red,
                      visualDensity: VisualDensity.compact,
                      value: 3,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                    const Text("I want to book another movie"),
                  ],
                ),
              ).paddingOnly(top: 5),
              SizedBox(
                height: 26,
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.red,
                      value: 4,
                      visualDensity: VisualDensity.compact,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                    const Text("Location is too far from my location"),
                  ],
                ),
              ).paddingOnly(top: 5),
              SizedBox(
                height: 26,
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.red,
                      value: 5,
                      groupValue: _value,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                    const Text("Another reason"),
                  ],
                ),
              ).paddingOnly(top: 5),
              30.height,
              AppTextField(
                textStyle: primaryTextStyle(size: 12),
                textFieldType: TextFieldType.MULTILINE,
                isValidationRequired: false,
                minLines: 5,
                decoration: inputDecoration(context, label: "Tell us reason"),
                onTap: () {
                  scrollController.animToBottom(milliseconds: 300);
                  setState(() {});
                },
              ),
            ],
          ),
          Positioned(
            bottom: 16,
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
                hideKeyboard(context);
                finish(context);
              },
              child: Text("Submit", style: boldTextStyle(color: white)),
            ),
          )
        ]),
      ).paddingAll(16),
    );
  }
}
