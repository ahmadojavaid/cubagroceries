// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../components/rounded_text_button.dart';
import '../../../utils/colors.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  const AddNewCardBottomSheet({super.key});

  @override
  _AddNewCardBottomSheetState createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        final isDarkMode = appStore.isDarkModeOn;

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDarkMode
                ? ColorScheme.dark(
                    primary: stayNestPrimaryColor,
                    onPrimary: Colors.white,
                    surface: Colors.grey.shade900,
                    onSurface: Colors.white,
                  )
                : ColorScheme.light(
                    primary: stayNestPrimaryColor,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
            dialogBackgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dobController.text = "${picked.month}/${picked.day}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Text(
              'Add New Card',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            20.height,
            CustomTextField(
              label: 'Card Number',
              hintText: '8976 5467 XX87 0098',
              controller: _numberController,
              keyboardType: TextInputType.phone,
            ),
            15.height,
            CustomTextField(
              label: 'Card Holder Name',
              hintText: 'Curtis Weaver',
              controller: _nameController,
            ),
            15.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Expiry Date',
                    hintText: '12/2026',
                    controller: _expiryController,
                    isDate: true,
                    onTap: () => _pickDate(),
                  ),
                ),
                10.width,
                Expanded(
                  child: CustomTextField(
                    label: 'CVV',
                    hintText: '•••',
                    controller: _cvvController,
                    obscureText: true,
                    isPassword: true,
                    toggleObscure: () {
                      setState(() {
                        _cvvController.text = _cvvController.text;
                      });
                    },
                  ),
                ),
              ],
            ),
            30.height,
            RoundedTextButton(
              text: 'Add Card',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
