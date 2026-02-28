import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

final List<Map<String, dynamic>> languageList = [
  {"flag": Image.asset(Images.ic_ukFlag), "name": "English(UK)"},
  {"flag": Image.asset(Images.ic_mandarinFlag), "name": "Mandarin"},
  {"flag": Image.asset(Images.ic_spanishFlag), "name": "Spanish"},
  {"flag": Image.asset(Images.ic_indiaFlag), "name": "Hindi"},
  {"flag": Image.asset(Images.ic_frenchFlag), "name": "French"},
  {"flag": Image.asset(Images.ic_arebicFlag), "name": "Arabic"},
  {"flag": Image.asset(Images.ic_rassiaFlag), "name": "Russian"},
  {"flag": Image.asset(Images.ic_japanFlag), "name": "Japanese"},
];

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                child: ListView.builder(
                  itemCount: languageList.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final language = languageList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 70,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: index == 0 ? PickColor.brownColor : PickColor.greyColor),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    child: language["flag"],
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(width: 18),
                                  Text(
                                    language["name"],
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (index == 0)
                                const Icon(
                                  Icons.check,
                                  color: PickColor.brownColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
