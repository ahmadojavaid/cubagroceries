import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constant.dart';
import '../utils/image.dart';

class ArticleCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isFavorite;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.image,
    required this.title,
    this.isFavorite = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              //TODO:
              child: Image.network(image, height: 120, width: 150, fit: BoxFit.cover),
            ),
            Observer(builder: (_) {
              bool isFav = favoriteStore.isFavorite(title);
              return Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                    onTap: () {
                      favoriteStore.toggleFavorite({"title": title, "image": image, 'type': "Article"});
                    },
                    child: ImageIcon(AssetImage(star), color: isFav ? Colors.yellow : Colors.white, size: 20)),
              );
            })
          ],
        ),
        8.height,
        SizedBox(
          width: 150,
          child: Text(
            title,
            style: primaryTextStyle(color: Colors.white, size: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).onTap(onTap);
  }
}
