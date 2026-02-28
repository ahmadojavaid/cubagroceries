import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/streamit/model/screeen_model.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';



class PopularTVCategory extends StatelessWidget {
  const PopularTVCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  streamITApString.popularTV,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: streamITAppColors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: streamITAppColors.white,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 70,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: tvCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final person = tvCategories[index];
                return SizedBox(
                  height: 70,
                  width: 180,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          person.image,
                          height: 70,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),                     
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                streamITAppColors.transparent,
                                streamITAppColors.black54,
                                streamITAppColors.black87,
                              ],
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            person.name,
                            style: GoogleFonts.roboto(
                              color: streamITAppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
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
