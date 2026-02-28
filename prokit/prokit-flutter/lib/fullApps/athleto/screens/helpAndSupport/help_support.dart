import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_Appbar.dart';
import '../../utils/colors.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int selectedIndex = 0;
  List<String> tabs = ["FAQ", "Contact Us"];
  List<Map<String, dynamic>> faqs = [
    {
      'question': 'How often should I work out?',
      'answer': """For general fitness: 3–5 days per week is ideal.
For weight loss: 4–5 days of a mix of cardio and strength training.
For muscle building: 4–6 days of strength training with rest days in between muscle groups.
Listen to your body and adjust as needed to avoid overtraining.""",
      'expanded': false
    },
    {
      'question': 'What is the best time of day to exercise?',
      'answer':
          """Morning workouts: Can boost metabolism and improve mood for the day.
Afternoon workouts: Best for strength training as your body temperature and strength levels are higher.
Evening workouts: Can help relieve stress but avoid intense workouts too close to bedtime.""",
      'expanded': false
    },
    {
      'question': 'How can I lose weight effectively?',
      'answer': """Combine strength training and cardio (HIIT is effective).
Maintain a calorie deficit by eating nutrient-dense foods.
Prioritize protein intake to preserve muscle while losing fat.
Stay consistent and monitor progress over time.

""",
      'expanded': false
    },
    {
      'question': 'Should I work out every day?',
      'answer': """Your body needs rest and recovery to repair and grow muscles.
3–5 days of training per week is effective for most people.
Include at least 1–2 rest days per week to avoid overtraining.
Active recovery (like walking or yoga) can be beneficial on rest days.""",
      'expanded': false
    },
    {
      'question': 'What are the benefits of strength training?',
      'answer': """
Increases muscle mass and improves metabolism.
Strengthens bones and reduces risk of injury.
Improves posture, balance, and mobility.
Enhances mental health by reducing anxiety and boosting confidence.
""",
      'expanded': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Help & FAQs",
        showBackButton: true,
        onBack: () => finish(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('How Can We Help You?',
                style: primaryTextStyle(
                    color: Colors.white, size: 18)),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: List.generate(tabs.length, (index) {
                bool isSelected = selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.009),
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? white : buttonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.040,
                          color: isSelected ? purpleColor : white,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ).paddingSymmetric(horizontal: 16),
            SizedBox(height: screenHeight * 0.03),
            selectedIndex == 0
                ? buildFAQSection(screenWidth, screenHeight)
                : buildContactSection(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget buildFAQSection(double screenWidth, double screenHeight) {
    return Column(
      children: [
        AppTextField(
          textFieldType: TextFieldType.NAME,
          textStyle: primaryTextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: primaryTextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.grey.shade900,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Icon(Icons.search, color: Colors.white54),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          height: screenHeight * 1.8,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              var item = faqs[index];
              return Column(
                children: [
                  Divider(color: Colors.yellow, thickness: 1),
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    title: Text(
                      item['question'],
                      style: boldTextStyle(
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    trailing: Icon(
                      item['expanded']
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.yellow,
                    ),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        item['expanded'] = expanded;
                      });
                    },
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        child: Text(
                          item['answer'],
                          style: primaryTextStyle(
                            color: Colors.white54,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Divider(color: Colors.yellow, thickness: 1),
                ],
              );
            },
          ),
        ),
        Divider(color: Colors.yellow, thickness: 1),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget buildContactSection(double screenWidth, double screenHeight) {
    return Column(
      children: [
        contactItem(Icons.headset_mic, 'Customer service', screenWidth)
            .onTap(() {}),
        contactItem(Icons.web, 'Website', screenWidth).onTap(() {}),
        contactItem(Icons.facebook, 'Facebook', screenWidth).onTap(() {}),
        contactItem(Icons.camera, 'Instagram', screenWidth).onTap(() {}),
      ],
    );
  }

  Widget contactItem(IconData icon, String title, double screenWidth) {
    return ListTile(
      leading: Icon(icon, color: primaryColor, size: 25),
      title: Text(title,
          style: primaryTextStyle(
              color: Colors.white, size: 18)),
      trailing: Icon(Icons.keyboard_arrow_right,
          color: Colors.yellowAccent, size:16),
    );
  }
}
