import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../models/category_model.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  late List<SelectCategory> categoryList;

  @override
  void initState() {
    super.initState();

    categoryList = getRomanceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: Text("Our Category", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: SizedBox(
        child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate((categoryList.length), (index) {
            var item = categoryList[index];
            return Column(
              children: [
                Container(
                  width: context.width(),
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {},
                      child: Image(
                        image: NetworkImage(item.image!),
                        height: 120,
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
      ).paddingAll(16),
    );
  }
}
