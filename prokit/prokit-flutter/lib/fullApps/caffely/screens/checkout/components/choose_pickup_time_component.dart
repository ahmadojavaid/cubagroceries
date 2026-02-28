import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class ChoosePickUpTimeComponent extends StatefulWidget {
  const ChoosePickUpTimeComponent({super.key});

  @override
  State<ChoosePickUpTimeComponent> createState() => _ChoosePickUpTimeComponentState();
}

class _ChoosePickUpTimeComponentState extends State<ChoosePickUpTimeComponent> {
  DateTime? _pickupTime;
  int _pickTime = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PickColor.greyColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
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
                                onTap: () {
                                  setState(() {
                                    _pickTime = 1;
                                    _pickupTime = DateTime.now(); // Set current time for "Pick Up Now"
                                  });
                                  Navigator.pop(context); // Close bottom sheet
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _pickTime == 1 ? PickColor.brownColor : PickColor.greyColor,
                                    ),
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
                                            child: Icon(
                                              Icons.check_box_outlined,
                                              size: 20,
                                            ),
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
                                onTap: () async {
                                  setState(() {
                                    _pickTime = 2;
                                  });
                                  Navigator.pop(context); // Close the bottom sheet
                                  // Show time picker for "Pick Up Later"
                                  TimeOfDay? selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedTime != null) {
                                    final now = DateTime.now();
                                    _pickupTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _pickTime == 2 ? PickColor.brownColor : PickColor.greyColor,
                                    ),
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
                                        const Icon(Icons.arrow_forward_ios, size: 20),
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
                      child: Icon(Icons.access_time, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _pickupTime == null
                              ? BottomSheetComponentText.choosePickupTime
                              : _pickupTime == DateTime.now()
                                  ? BottomSheetComponentText.pickupNow
                                  : 'Pickup at ${_pickupTime?.hour}:${_pickupTime?.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          CheckOutText.takeOrderDirectly,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: PickColor.greyColor),
            const SizedBox(height: 10),
            const Text(CheckOutText.takeOrderAt),
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
          ],
        ),
      ),
    );
  }
}
