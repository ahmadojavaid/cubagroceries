import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/common.dart';

class LanguageCard extends StatelessWidget {
  LanguageCard({super.key});
  final List<String> languages = [
    "English",
    "French",
    "German",
    "Hindi",
    "Spanish",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRowWidget(streamITApString.language),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                String language = languages[index];
                return Padding(
                  padding:  EdgeInsets.only(left: index == 0 ? 16.0:0,right: index == languages.length - 1 ? 16.0:0),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: streamITAppColors.fadeBlack,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 0.6, color: streamITAppColors.white10),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: streamITAppColors.avatarBG,
                          child: Text(
                            language[0],
                            style: GoogleFonts.roboto(
                              color: streamITAppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          language,
                          style: GoogleFonts.roboto(
                            color: streamITAppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
