import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  State<PrivacyAndPolicyScreen> createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: Text("Privacy policy", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("last updated 17/2/2023", style: TextStyle(color: Colors.black54)),
          const Text("Please read these Privacy policy carefully before using our app operated by us.").paddingOnly(top: 16),
          const Text(
            "Privacy policy",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ).paddingOnly(top: 16),
          const Text("Bookmyshow respects your privacy and recognizes the need to protect your personal information (any information by which you can be identified, such as name, address, financial information,"
                  "and telephone number) you share with us. We would like to assure you that we follow appropriate standards when it comes to protecting your privacy on our web sites and applications.")
              .paddingOnly(top: 16),
          const Text(
              "In general, you can visit Bookmyshow without telling us who you are or revealing any personal information about yourself. We track the Internet address of the domains from which people visit us and analyze this data for trends and statistics, but the individual user remains anonymous"),
          const Text("Please note that our Privacy Policy forms part of our Terms and conditions available at"),
          const Text(
              "A transaction on Bookmyshow is to be conducted by persons above the age of 18 years only. If you are under 18 years of age, you are not allowed to make a transaction in Bookmyshow. It is the duty of the legal guardians of all persons below 18 years of age to ensure that their wards do not make a transaction without their supervision on Bookmyshow. It shall be automatically deemed that by allowing any person below the age of 18 years to transact on Bookmyshow, their legal guardians have expressly consented to their use and we disclaim any liability arising from your failure to do soWe may collect your personal data")
        ],
      ).paddingAll(16),
    );
  }
}
