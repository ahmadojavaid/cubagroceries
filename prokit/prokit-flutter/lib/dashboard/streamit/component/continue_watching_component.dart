import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/streamit/model/screeen_model.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/common.dart';


class ContinueWatchingSection extends StatelessWidget {
  const ContinueWatchingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRowWidget(streamITApString.continueWatching),
          const SizedBox(height: 8),
          SizedBox(
            height: 156,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: continueWatchingList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final movie = continueWatchingList[index];
                return Stack(
                  children: [
                    SizedBox(
                      width: 220,
                      height: 154,
                      child: Container(
                        decoration: BoxDecoration(
                          color: streamITAppColors.fadeBlack,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 220,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  movie.imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value:
                                      0.4, 
                                  minHeight: 4,
                                  backgroundColor: streamITAppColors.grey800,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    streamITAppColors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                            Text(movie.title, style: _textStyle()),
                            Text(
                              movie.duration,
                              style: _textStyle(fontSize: 12, opacity: 0.6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: streamITAppColors.red,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: streamITAppColors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  TextStyle _textStyle({double fontSize = 14, double opacity = 1}) => GoogleFonts.roboto(
    color: streamITAppColors.white.withAlpha((opacity * 255).toInt()),
    fontSize: fontSize,
  );
}
