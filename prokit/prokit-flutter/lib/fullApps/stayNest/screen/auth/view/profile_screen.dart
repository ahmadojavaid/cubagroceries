import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../page_slider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String gender = 'Male';
  Country _selectedCountry = Country.parse('US');

  Future<void> pickDate() async {
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
            dialogTheme: DialogThemeData(backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dobController.text = "${picked.month}/${picked.day}/${picked.year}";
    }
  }

  Future<void> _selectDOB() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() => _selectedCountry = country);
      },
    );
  }

  void _submitForm() {
    PageSlider().launch(context);
  }

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        title: const Text("Fill Your Profile"),
        leading: const BackButton(),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : const AssetImage(userImage) as ImageProvider,
                  ),
                  GestureDetector(
                    onTap: pickDate,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: stayNestPrimaryColor,
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  CustomTextField(
                    label: "Full Name",
                    hintText: "Enter your name",
                  ),
                  10.height,
                  CustomTextField(
                    label: "Username",
                    hintText: "Enter username",
                  ),
                  10.height,
                  CustomTextField(
                    label: "Date of Birth",
                    hintText: "Select date of birth",
                    isDate: true,
                    onTap: _selectDOB,
                  ),
                  10.height,
                  CustomTextField(
                    label: "Email",
                    hintText: "Enter valid email",
                    controller: emailController,
                  ),
                  10.height,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _selectCountry,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appStore.isDarkModeOn ? const Color.fromARGB(255, 62, 62, 62) : stayNestPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('+${_selectedCountry.phoneCode}'),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: stayNestPrimaryColor),
                            labelStyle: TextStyle(color: stayNestPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: appStore.isDarkModeOn ? const Color.fromARGB(255, 62, 62, 62) : stayNestPrimaryColor,
                              ),
                            ),
                            labelText: 'Phone Number',
                          ),
                          validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
                        ),
                      ),
                    ],
                  ),
                  14.height,
                  const Text(
                    "Gender",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).paddingLeft(3),
                ],
              ).paddingSymmetric(horizontal: 16),
              Row(
                children: [
                  genderOption("Male"),
                  20.width,
                  genderOption("Female"),
                ],
              ).paddingLeft(5),
              30.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: stayNestPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderOption(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: gender,
          activeColor: stayNestPrimaryColor,
          onChanged: (val) {
            setState(() {
              gender = val!;
            });
          },
        ),
        Text(value),
      ],
    );
  }
}
