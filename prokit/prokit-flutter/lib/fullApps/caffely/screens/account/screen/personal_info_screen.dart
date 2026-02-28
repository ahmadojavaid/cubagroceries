import 'package:flutter/material.dart';

import '../../../utils/comman.dart';
import '../components/personal_info_component.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Personal Info",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: PersonalInfoComponent(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BottomButton(
              btnText: "Save",
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
