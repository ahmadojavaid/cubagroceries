import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/athleto/utils/colors.dart';

import '../../component/challenges_card.dart';
import '../../component/custom_Appbar.dart';
import '../../utils/constant.dart';
import 'details_article_tips.dart';

class ArticleTipScreen extends StatefulWidget {
  const ArticleTipScreen({super.key});

  @override
  State<ArticleTipScreen> createState() => _ArticleTipScreenState();
}

class _ArticleTipScreenState extends State<ArticleTipScreen> {
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Article and Tips",
        onBack: () {
          finish(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 900,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: articleList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ChallengesCard(
                      imagePath: articleList[index].imagePath,
                      title: articleList[index].title,
                      onTap: () {
                        DetailArticleScreen(
                          imagePath: articleList[index].imagePath,
                          title: articleList[index].title,
                        ).launch(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
