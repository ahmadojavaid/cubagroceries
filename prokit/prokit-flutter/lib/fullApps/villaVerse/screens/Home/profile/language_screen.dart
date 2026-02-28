import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  setValue(Language? newValue) {
    setState(() {
      _selectedLanguage = newValue!;
    });
  }

  Language _selectedLanguage = Language.englishUS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Select Language'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text("Suggested", style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
            16.height,
            radioButtonSelection('English (US)', Language.englishUS),
            radioButtonSelection('English (UK)', Language.englishUK),
            Divider(color: context.cardColor).paddingSymmetric(horizontal: 16),
            Text("Language ", style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
            16.height,
            radioButtonSelection('Hindi', Language.hindi),
            radioButtonSelection('Gujarati', Language.gujarati),
            radioButtonSelection('French', Language.french),
            radioButtonSelection('Arabic', Language.arabic),
            radioButtonSelection('Bengali', Language.bengali),
            radioButtonSelection('Indonesia', Language.indonesia),
            radioButtonSelection('Marathi', Language.marathi),
            radioButtonSelection('Russian', Language.russian),
            radioButtonSelection('Spanish', Language.spanish),
            radioButtonSelection('Urdu  ', Language.urdu),
          ],
        ),
      ),
    );
  }

  Widget radioButtonSelection(String text, Language value) {
    return RadioListTile(
      value: value,
      groupValue: _selectedLanguage,
      onChanged: (Language? newValue) {
        setState(() {
          _selectedLanguage = newValue!;
        });
      },
      fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        return primaryBlueColor;
      }),
      title: Text(
        text,
        style: primaryTextStyle(),
      ),
    );
  }
}
