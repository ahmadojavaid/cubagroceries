import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class AboutCaffelyScreen extends StatefulWidget {
  const AboutCaffelyScreen({super.key});

  @override
  State<AboutCaffelyScreen> createState() => _AboutCaffelyScreenState();
}

final List aboutList = [
  "Terms and Conditions",
  "Privacy Policy",
  "Job Vacancy",
  "Contact us",
  "Partner",
  "Accessibility",
  "Feedback",
  "Rate us",
  "Visit Our Website",
  "Follow us on Social Media",
];

class _AboutCaffelyScreenState extends State<AboutCaffelyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Caffely", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.ic_appIcon,
                      height: 100,
                      width: 100,
                    ),
                    const Text(
                      "Caffely v5.6.8",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: PickColor.borderColor),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: aboutList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          aboutList[index],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
