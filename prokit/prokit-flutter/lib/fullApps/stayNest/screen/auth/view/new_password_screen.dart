import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../components/new_password_components/password_updated_dialog.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool _obscureConfirm = false;
  bool obscurePassword = false;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void togglecPasswordVisibility() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
    });
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
        centerTitle: true,
        title: Text(""),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter New Password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            8.height,
            const Text(
              "Please enter new password",
              style: TextStyle(color: Colors.grey),
            ),
            24.height,
            Center(
              child: Image.asset(password, height: 250),
            ),
            32.height,
            CustomTextField(
              label: 'Password',
              hintText: 'Enter your password',
              obscureText: obscurePassword,
              toggleObscure: togglePasswordVisibility,
              isPassword: true,
            ),
            10.height,
            CustomTextField(
              label: 'Conform Password',
              hintText: 'Conform password',
              obscureText: _obscureConfirm,
              toggleObscure: togglecPasswordVisibility,
              isPassword: true,
            ),
            16.height,
            32.height,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  hideKeyboard(context);
                  showPasswordUpdatedDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: stayNestPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
