import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/category_model.dart';
import '../../../utils/images.dart';
import '../category/view/view_all_category.dart';
import '../movie/favourite_movie/view/all_favourite_movie.dart';
import '../movie/favourite_movie/model/favourite_movie_model.dart';
import '../movie/latest_movie/view/all_latest_movie.dart';
import '../movie/latest_movie/model/latest_movie_model.dart';
import '../movie/view/movie_detail_screen.dart';
import '../notification/view/notification_screen.dart';

class HomeFragment extends StatefulWidget {
  final Function(int) onTabSelected;

  const HomeFragment({super.key, required this.onTabSelected});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  late List<SelectCategory> categoryList;
  late List<LatestMovie> latestMovieList;
  late List<FavouriteMovie> favouriteMovieList;

  @override
  void initState() {
    super.initState();
    categoryList = getRomanceList();
    latestMovieList = getLatestMovieList();
    favouriteMovieList = getFavourItemMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${"Welcome Mark"}${"👋🏻"}",
                      style: boldTextStyle(size: 20),
                    ),
                    Text(
                      "Book your favourite movie",
                      style: secondaryTextStyle(),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    const NotificationScreen().launch(context);
                  },
                  icon: const Icon(Icons.notifications_active_outlined, size: 22),
                )
              ],
            ).paddingSymmetric(horizontal: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onTabSelected(1);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.black38,
                          size: 22,
                        ).paddingOnly(left: 10),
                        Text(" Search ", style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                ).expand(),
                16.width,
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
                      child: Image(
                        image: NetworkImage(filterIcon),
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingOnly(top: 16, left: 16, right: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category", style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 18)),
                TextButton(
                  onPressed: () {
                    const AllCategoryScreen().launch(context);
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            SizedBox(
              child: GridView.count(
                crossAxisSpacing: 16,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(min(categoryList.length, 6), (index) {
                  var item = categoryList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: context.width(),
                          height: 75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: NetworkImage(item.image!),
                              height: 75,
                              width: context.width(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(item.name!).paddingOnly(top: 3),
                    ],
                  );
                }),
              ),
            ).paddingSymmetric(horizontal: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Latest Movie", style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 18)),
                TextButton(
                  onPressed: () {
                    const AllLatestMovieScreen().launch(context);
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: min(latestMovieList.length, 3),
                itemBuilder: (BuildContext context, int index) {
                  var branch = latestMovieList[index];

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: NetworkImage(branch.image!),
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(branch.title!, style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)).paddingOnly(top: 4),
                            Text(branch.subtitle!, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 8, right: 8);
                },
              ),
            ).paddingSymmetric(horizontal: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Favourite Movie", style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 18)),
                TextButton(
                  onPressed: () {
                    const AllFavouriteMovieScreen().launch(context);
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: min(favouriteMovieList.length, 3),
                itemBuilder: (BuildContext context, int index) {
                  var favouriteMovieListData = favouriteMovieList[index];

                  return GestureDetector(
                    onTap: () {
                      AllMovieDetailScreen(
                        image: favouriteMovieListData.image!,
                        title: favouriteMovieListData.title!,
                        subtitle: favouriteMovieListData.subtitle!,
                        description: favouriteMovieListData.description!,
                        types: favouriteMovieListData.type!,
                        duration: favouriteMovieListData.duration!,
                        rating: favouriteMovieListData.rating!,
                      ).launch(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: NetworkImage(favouriteMovieListData.image!),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(favouriteMovieListData.title!, style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)).paddingOnly(top: 4),
                            Text(favouriteMovieListData.subtitle!, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 8, right: 8);
                },
              ),
            ).paddingSymmetric(horizontal: 8),
          ],
        ).paddingOnly(top: 10, bottom: 16),
      ),
    );
  }
}
