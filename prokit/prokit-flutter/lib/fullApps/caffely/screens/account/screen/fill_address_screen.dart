import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/saved_address_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';

class FillAddressScreen extends StatefulWidget {
  final String address;

  const FillAddressScreen({super.key, required this.address});

  @override
  State<FillAddressScreen> createState() => _FillAddressScreenState();
}

class _FillAddressScreenState extends State<FillAddressScreen> {
  bool isRememberMeChecked = false;

  final TextEditingController addressLabelController = TextEditingController(text: "Work Office");

  final TextEditingController recipientsController = TextEditingController(text: "Andrew Ainley");

  final TextEditingController phoneController = TextEditingController(text: "1114673785");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("Address Details", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: PickColor.brownColor),
                const SizedBox(width: 5),
                Text(widget.address),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Address Labels",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressLabelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: PickColor.textFeildColor,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                isDense: true,
                hintText: "Enter your address",
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Note to Courier  (optional)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: PickColor.textFeildColor,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                isDense: true,
                hintText: "Note",
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Recipient's Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: recipientsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: PickColor.textFeildColor,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                isDense: true,
                hintText: "Note",
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Recipient's Phone Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            IntlPhoneField(
              controller: phoneController,
              decoration: const InputDecoration(
                fillColor: PickColor.textFeildColor,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: "111467378399",
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  side: const BorderSide(color: PickColor.brownColor),
                  activeColor: PickColor.brownColor,
                  value: isRememberMeChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isRememberMeChecked = value ?? false;
                    });
                  },
                ),
                const Text("Set As Primary Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomButton(
          btnText: "Save",
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedAddressScreen()),
            ),
          },
        ),
      ),
    );
  }
}
