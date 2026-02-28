import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../movie/model/movie_model.dart';
import '../movie/view/movie_detail_screen.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({super.key});

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  late List<AllMovie> allMovieData;
  List<AllMovie> displayedMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allMovieData = getAllMovieList();
    displayedMovies = allMovieData;
  }

  void filterMovies(String query) {
    final filteredMovies = allMovieData.where((movie) {
      final titleLower = movie.title!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      displayedMovies = filteredMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    fillColor: context.cardColor,
                    filled: true,
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, size: 22),
                    hintStyle: secondaryTextStyle(),
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: radius(10)),
                  ),
                  onChanged: (query) {
                    filterMovies(query);
                  },
                ),
              ),
              16.height,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedMovies.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  AllMovie movieObj = displayedMovies[index];
                  return GestureDetector(
                    onTap: () {
                      AllMovieDetailScreen(
                        image: movieObj.image!,
                        title: movieObj.title!,
                        subtitle: movieObj.subtitle!,
                        description: movieObj.description!,
                        types: movieObj.type!,
                        duration: movieObj.duration!,
                        rating: movieObj.rating!,
                      ).launch(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: NetworkImage(movieObj.image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieObj.title!,
                                  style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(movieObj.subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis).paddingOnly(top: 10),
                                Text(
                                  'Language: ${movieObj.language!}',
                                  style: TextStyle(fontWeight: fontWeightBoldGlobal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ).paddingOnly(top: 10),
                              ],
                            ).paddingOnly(left: 16).expand()
                          ],
                        ),
                      ),
                    ).paddingOnly(top: 16),
                  );
                },
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
