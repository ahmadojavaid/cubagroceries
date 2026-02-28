import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import 'all_set_screen.dart';

class CompleteYourProfileScreen extends StatefulWidget {
  const CompleteYourProfileScreen({super.key});

  @override
  State<CompleteYourProfileScreen> createState() => _CompleteYourProfileState();
}

class _CompleteYourProfileState extends State<CompleteYourProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode birthdateFocusNode = FocusNode();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    birthdateController.dispose();

    fullNameFocusNode.dispose();
    phoneFocusNode.dispose();
    birthdateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    SigInUpText.completeProfile,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(SigInUpText.addFinishing),
                  const SizedBox(height: 24),
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
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 22,
                                width: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: PickColor.brownColor,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 13,
                                  color: PickColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(SigInUpText.fullName),
                  TextField(
                    controller: fullNameController,
                    focusNode: fullNameFocusNode,
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
                      hintText: SigInUpText.andrew,
                      hintStyle: TextStyle(color: PickColor.greyColor),
                    ),
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(phoneFocusNode);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(SigInUpText.phone),
                  IntlPhoneField(
                    controller: phoneController,
                    focusNode: phoneFocusNode,
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
                      hintText: SigInUpText.phoneHint,
                      hintStyle: TextStyle(color: PickColor.greyColor),
                    ),
                    onCountryChanged: (country) {},
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(birthdateFocusNode);
                    },
                  ),
                  const SizedBox(height: 5),
                  const Text(SigInUpText.dateOfBirth),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          birthdateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: birthdateController,
                        focusNode: birthdateFocusNode,
                        decoration: InputDecoration(
                          fillColor: PickColor.textFeildColor,
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
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  birthdateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                                }
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  const SizedBox(height: 220),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0, // Set this to 0 to stick the button to the bottom
            left: 16.0,
            right: 16.0,
            child: BottomButton(
              btnText: "Sign up",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllSetScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
