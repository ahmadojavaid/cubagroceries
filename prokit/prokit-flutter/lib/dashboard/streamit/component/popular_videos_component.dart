import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/streamit/model/screeen_model.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/common.dart';

class PopularVideos extends StatelessWidget {
  const PopularVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          titleRowWidget(streamITApString.popularVid),
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
                        child: Image.network(image.images,
                            fit: BoxFit
                                .cover),
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
