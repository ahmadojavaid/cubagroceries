import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/streamit/component/texture_number_component.dart';
import 'package:prokit_flutter/dashboard/streamit/model/screeen_model.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/streamit/utils/common.dart';

class Top10MoviesSection extends StatelessWidget {
  const Top10MoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRowWidget(streamITApString.top10),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final image = topMovies[index];
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
                      left: 0,
                      bottom: -30,
                      child: TexturedNumber(number: index + 1,textureUrl: streamITAppImages.texture,),
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
