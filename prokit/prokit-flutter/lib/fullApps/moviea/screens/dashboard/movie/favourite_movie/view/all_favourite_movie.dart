import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../view/movie_detail_screen.dart';
import '../model/favourite_movie_model.dart';

class AllFavouriteMovieScreen extends StatefulWidget {
  const AllFavouriteMovieScreen({super.key});

  @override
  State<AllFavouriteMovieScreen> createState() => _AllFavouriteMovieScreenState();
}

class _AllFavouriteMovieScreenState extends State<AllFavouriteMovieScreen> {
  late List<FavouriteMovie> favouriteMovieList;

  @override
  void initState() {
    super.initState();

    favouriteMovieList = getFavourItemMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text("Favorit Movie", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate((favouriteMovieList.length), (index) {
              var branch = favouriteMovieList[index];
              return GestureDetector(
                onTap: () {
                  AllMovieDetailScreen(
                    image: branch.image!,
                    title: branch.title!,
                    subtitle: branch.subtitle!,
                    description: branch.description!,
                    types: branch.type!,
                    duration: branch.duration!,
                    rating: branch.language!,
                  ).launch(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(branch.image!),
                        height: 122,
                        width: context.width(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      branch.title!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ).paddingOnly(top: 2),
                    Text(branch.subtitle!, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }),
          ),
        ).paddingAll(14),
      ),
    );
  }
}
