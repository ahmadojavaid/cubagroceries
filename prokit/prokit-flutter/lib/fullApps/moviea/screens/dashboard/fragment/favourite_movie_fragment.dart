import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../movie/favourite_movie/model/favourite_movie_model.dart';
import '../movie/view/movie_detail_screen.dart';

class FavouriteMovieFragment extends StatefulWidget {
  const FavouriteMovieFragment({super.key});

  @override
  State<FavouriteMovieFragment> createState() => _FavouriteMovieFragmentState();
}

class _FavouriteMovieFragmentState extends State<FavouriteMovieFragment> {
  late List<FavouriteMovie> favouriteMovieList;

  @override
  void initState() {
    super.initState();

    favouriteMovieList = getFavourItemMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Favourite Movie", style: boldTextStyle(size: 20, color: Colors.black)),
              16.height,
              SizedBox(
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
                          rating: branch.rating!,
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
                          Text(branch.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)).paddingOnly(top: 2),
                          Text(branch.subtitle!, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ).paddingAll(14),
        ),
      ),
    );
  }
}
