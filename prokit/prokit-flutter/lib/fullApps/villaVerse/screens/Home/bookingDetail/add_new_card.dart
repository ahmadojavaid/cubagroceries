// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../component/custome_app_text_field.dart';
import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary:
                        primaryBlueColor, // header background color & selected date
                    onPrimary: lightColor, // text color on selected date
                    onSurface: lightColor, // default text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          primaryBlueColor, // button text color (OK, Cancel)
                    ),
                  ),
                )
              : Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary:
                        primaryBlueColor, // header background color & selected date
                    onPrimary: lightColor, // text color on selected date
                    onSurface: darkColor, // default text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          primaryBlueColor, // button text color (OK, Cancel)
                    ),
                  ),
                ),
          child: child!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Add New Card'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width(),
                height: 200,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2979FF), Color(0xFF448AFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Mocard",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "amazon",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // Card number (dots)
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "●●●●  ●●●●  ●●●●  ●●●●",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom section
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Card holder
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Card Holder name",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              SizedBox(height: 4),
                              Text("•••• ••••",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          // Expiry date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "Expiry date",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "••/••",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const CustomAppTextField(
                label: "Card Name",
                hintTextColor: hintTextColor,
                hint: "Andrew Ainsley",
              ),
              const CustomAppTextField(
                label: "Card Number",
                hint: "2672 4738 7837 7285",
                hintTextColor: hintTextColor,
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomAppTextField(
                      label: "Expiry Date",
                      hint: "09/07/26",
                      hintTextColor: hintTextColor,
                      keyboardType: TextInputType.datetime,
                      suffixIcon: InkWell(
                        onTap: () => _selectDate(context),
                        child: const Icon(Icons.calendar_today,
                            size: 18, color: hintTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: CustomAppTextField(
                      label: "CVV",
                      hint: "699",
                      hintTextColor: hintTextColor,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppButton(
        text: 'Add',
        textColor: lightColor,
        color: primaryBlueColor,
        onTap: () => finish(context),
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ).paddingAll(16),
    );
  }
}
