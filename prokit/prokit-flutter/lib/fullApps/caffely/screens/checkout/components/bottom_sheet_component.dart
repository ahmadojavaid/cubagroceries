import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/checkout/components/time_picker_component.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class BottomSheetComponent extends StatefulWidget {
  const BottomSheetComponent({super.key});

  @override
  State<BottomSheetComponent> createState() => _BottomSheetComponentState();
}

class _BottomSheetComponentState extends State<BottomSheetComponent> {
  int _pickTime = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: PickColor.brownColor),
            child: const Text(
              "Place Order",
              style: TextStyle(color: PickColor.whiteColor),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: PickColor.whiteColor,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 350,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              BottomSheetComponentText.choosePickupTime,
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _pickTime = 1;
                                }),
                                showBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SizedBox(
                                      height: 350,
                                      child: Text(BottomSheetComponentText.timer),
                                    );
                                  },
                                )
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: _pickTime == 1 ? PickColor.brownColor : PickColor.greyColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Row(
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
                                          child: Icon(Icons.check_box_outlined, size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              BottomSheetComponentText.pickupNow,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              BottomSheetComponentText.estimateTime,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _pickTime = 2;
                                }),
                                Navigator.pop(context),
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  builder: (BuildContext context) {
                                    return const TimePickerComponent();
                                  },
                                )
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: _pickTime == 2 ? PickColor.brownColor : PickColor.greyColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Row(
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
                                          child: Icon(Icons.access_time, size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              BottomSheetComponentText.pickupLater,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              BottomSheetComponentText.setPickupTime,
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
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                                        backgroundColor: PickColor.brownColor,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        BottomSheetComponentText.confirm,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
