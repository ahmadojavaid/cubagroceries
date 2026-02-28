import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class PersonalInfoComponent extends StatefulWidget {
  const PersonalInfoComponent({super.key});

  @override
  State<PersonalInfoComponent> createState() => _PersonalInfoComponentState();
}

class _PersonalInfoComponentState extends State<PersonalInfoComponent> {
  TextEditingController nameController = TextEditingController(text: "Andrew Anisley");
  TextEditingController emailController = TextEditingController(text: "andrew.ainsley@yourdomain.com");
  TextEditingController phoneController = TextEditingController(text: "1114673783");
  TextEditingController birthDate = TextEditingController(text: "12/12/1995");
  TextEditingController gender = TextEditingController(text: "Male");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: PickColor.blackColor.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            Images.img_user,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: Container(
                        height: 22,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: PickColor.brownColor,
                        ),
                        child: const Icon(Icons.edit, size: 15, color: PickColor.whiteColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(SigInUpText.fullName, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                fillColor: PickColor.borderColor,
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
                hintText: SigInUpText.andrew,
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Email", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail),
                fillColor: PickColor.borderColor,
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
                hintText: SigInUpText.andrew,
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
            const SizedBox(height: 16),
            const Text(SigInUpText.phone, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            IntlPhoneField(
              controller: phoneController,
              decoration: const InputDecoration(
                fillColor: PickColor.borderColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: SigInUpText.phoneHint,
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
              initialCountryCode: 'US', // Example country code
            ),
            const SizedBox(height: 5),
            const Text(SigInUpText.dateOfBirth, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: birthDate,
              decoration: InputDecoration(
                fillColor: PickColor.borderColor,
                filled: true,
                border: InputBorder.none,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: PickColor.blackTransparent),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: SigInUpText.dateHint,
                hintStyle: const TextStyle(color: PickColor.greyColor),
                suffixIcon: IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Gender", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: gender,
              decoration: const InputDecoration(
                fillColor: PickColor.borderColor,
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
                hintText: SigInUpText.dateHint,
                hintStyle: TextStyle(color: PickColor.greyColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
