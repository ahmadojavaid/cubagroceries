import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String selectedMethod = 'sms';

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: appStore.isDarkModeOn
                  ? TextStyle(color: whiteColor, fontSize: 24)
                  : primaryTextStyle(
                      size: 24,
                      weight: FontWeight.bold,
                    ),
            ),
            8.height,
            Text(
              "Select which contact details should we use to reset your password",
              style: secondaryTextStyle(),
            ),
            24.height,
            Center(
              child: Image.asset(forgetimg, height: 250),
            ),
            32.height,
            _buildOption(
              method: 'sms',
              icon: Icons.message,
              title: 'Send OTP via SMS',
              subtitle: '(209) 555-0104',
            ),
            16.height,
            _buildOption(
              method: 'email',
              icon: Icons.email,
              title: 'Send OTP via Email',
              subtitle: 'curtis.weaver@example.com',
            ),
            20.height,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  OtpVerificationScreen().launch(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: stayNestPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: primaryTextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String method,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    bool isSelected = selectedMethod == method;

    return InkWell(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? stayNestPrimaryColor : Colors.grey,
            width: 1.8,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? stayNestPrimaryColor : Colors.grey.shade300,
              child: Icon(icon, color: Colors.white),
            ),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: primaryTextStyle(size: 14, weight: FontWeight.bold),
                ),
                4.height,
                Text(subtitle, style: secondaryTextStyle(size: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
