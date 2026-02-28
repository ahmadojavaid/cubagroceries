import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../components/rounded_text_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController dobController = TextEditingController();

  final TextEditingController _nameController = TextEditingController(
    text: 'Curtis Weaver',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'curtis.weaver@example.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '(209) 555-0104',
  );
  final DateTime _dob = DateTime(2023, 8, 14);
  String _gender = 'Male';

  String get formattedDate => DateFormat.yMMMMd().format(_dob);

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
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
      ),
    );
  }

  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      // backgroundColor: stayNestPrimaryColor,
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : const AssetImage(userImage) as ImageProvider,
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: stayNestPrimaryColor,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                24.height,
                CustomTextField(
                  label: 'Name',
                  hintText: 'Enter your name',
                  controller: _nameController,
                ),
                16.height,
                CustomTextField(
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  controller: _emailController,
                ),
                16.height,
                CustomTextField(
                  label: 'Mobile Number',
                  hintText: 'Enter your phone number',
                  controller: _phoneController,
                ),
                16.height,
                CustomTextField(
                  label: 'Date of Birth',
                  hintText: 'Select your birth date',
                  controller: TextEditingController(text: formattedDate),
                  isDate: true,
                  onTap: pickDate,
                ),
                24.height,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                8.height,
              ],
            ).paddingSymmetric(horizontal: 16),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _gender,
                  activeColor: stayNestPrimaryColor,
                  onChanged: (value) => setState(() => _gender = value!),
                ),
                const Text('Male'),
                const SizedBox(width: 32),
                Radio<String>(
                  value: 'Female',
                  groupValue: _gender,
                  activeColor: stayNestPrimaryColor,
                  onChanged: (value) => setState(() => _gender = value!),
                ),
                const Text('Female'),
              ],
            ).paddingSymmetric(horizontal: 2),
            32.height,
            RoundedTextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: "Update",
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }
}
