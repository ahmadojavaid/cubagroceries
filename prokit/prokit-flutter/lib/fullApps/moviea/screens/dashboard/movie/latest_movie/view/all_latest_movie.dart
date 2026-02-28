import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../view/movie_detail_screen.dart';
import '../model/latest_movie_model.dart';

class AllLatestMovieScreen extends StatefulWidget {
  const AllLatestMovieScreen({super.key});

  @override
  State<AllLatestMovieScreen> createState() => _AllLatestMovieScreenState();
}

class _AllLatestMovieScreenState extends State<AllLatestMovieScreen> {
  late List<LatestMovie> latestMovieList;

  @override
  void initState() {
    super.initState();

    latestMovieList = getLatestMovieList();
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
        title: Text("Latest Movie", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(latestMovieList.length, (index) {
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
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(branch.image!),
                      height: 122, // Set the fixed height of the image
                      width: double.infinity, // Make the image take the full width of its container
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
        ).paddingAll(14),
      ),
    );
  }
}
