import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../googlemap/screen/addmylocation_screen.dart';
import '../model/saved_address_model.dart';
import 'accoount_home_screen.dart';

class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

List<SavedAddressModel> savedAddressDetail = savedAddressList();

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  List<GlobalKey> _moreOptionsKeys = []; // List to store GlobalKeys for each row item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMyLocationScreen()));
              },
              icon: const Icon(Icons.add, color: PickColor.blackColor),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 70),
            itemCount: savedAddressDetail.length,
            itemBuilder: (context, index) {
              // Create a unique GlobalKey for each IconButton
              if (_moreOptionsKeys.length <= index) {
                _moreOptionsKeys.add(GlobalKey()); // Add new key if it doesn't exist
              }
              final addressData = savedAddressDetail[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PickColor.borderColor),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  addressData.title,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                if (index == 0)
                                  Container(
                                    height: 30,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: PickColor.brownColor),
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        ChooseDeliveryAddress.mainAddress,
                                        style: TextStyle(color: PickColor.brownColor, fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const Icon(Icons.share_outlined),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: PickColor.borderColor),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              addressData.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              ChooseDeliveryAddress.contact1,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(addressData.address),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(ChooseDeliveryAddress.pinpointAlready),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            if (index == 0)
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(color: PickColor.brownColor),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: const Text("Change Address", style: TextStyle(color: PickColor.brownColor)),
                                ),
                              ),
                            if (index != 0)
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(color: PickColor.brownColor),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: const Text("Change Address", style: TextStyle(color: PickColor.brownColor)),
                                ),
                              ),
                            if (index > 0) const SizedBox(width: 10),
                            if (index > 0)
                              Container(
                                key: _moreOptionsKeys[index],
                                // Use the unique key for this row item
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                  border: Border.all(color: PickColor.brownColor),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    final RenderBox renderBox = _moreOptionsKeys[index].currentContext!.findRenderObject() as RenderBox;
                                    final position = renderBox.localToGlobal(Offset.zero); // Get the position of the icon button

                                    showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(position.dx, position.dy + 50, 50.0, 0.0), // Position the menu below the button
                                      items: [
                                        const PopupMenuItem(
                                          value: 1,
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          height: 24,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.location_on_outlined, size: 20),
                                              SizedBox(width: 8),
                                              Text("Set As Primary Address", style: TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          height: 1,
                                          child: Divider(color: PickColor.borderColor),
                                        ),
                                        const PopupMenuItem(
                                          value: 2,
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          height: 24,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.delete_outline, color: PickColor.redColor, size: 20),
                                              SizedBox(width: 8),
                                              Text("Delete Address", style: TextStyle(fontSize: 14, color: PickColor.redColor)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: PickColor.brownColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          child: BottomButton(
            btnText: "Ok",
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountHomeScreen())),
            },
          ),
        )
      ]),
    );
  }
}
