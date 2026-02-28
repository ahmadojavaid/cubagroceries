import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/streamit/model/screeen_model.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/common.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          titleRowWidget(streamITApString.popularMovies),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: popularMovies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final image = popularMovies[index];
                return Stack(
                  children: [
                    SizedBox(
                      height: 180,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(image.images, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          color: streamITAppColors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            streamITApString.free,
                            style: GoogleFonts.roboto(
                              color: streamITAppColors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
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
}
