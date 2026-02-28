import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/main/utils/like_button/like_button.dart';
import 'package:prokit_flutter/main/utils/like_button/utils/like_button_model.dart';
import 'package:prokit_flutter/main/utils/like_button/utils/like_button_typedef.dart';

import '../../../main.dart';

class LBHomePage extends StatefulWidget {
  static String tag = '/ui_interaction_home_page';

  final bool isDirect;

  LBHomePage({this.isDirect = false});

  @override
  _LBHomePageState createState() => _LBHomePageState();
}

class _LBHomePageState extends State<LBHomePage> {
//   You can set the initial value of the count.
  final int likeCount = 999;

//   Set thr Size of the Button/Icons.
  final double buttonSize = 30.0;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: Image.network('https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250').image,
                  ),
                ),
              ),
              Expanded(
                child: Container(padding: EdgeInsets.only(left: 10), child: Text('John Doe', style: primaryTextStyle(size: 18))),
              ),
              Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.more_vert, color: appStore.iconColor))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: FadeInImage(
              image: Image.network('https://plus.unsplash.com/premium_photo-1663858367108-9150fe5ce9bd?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D').image,
              placeholder: Image.asset('images/app/placeholder.jpg').image,
            ),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, 'Like Buttons', isDashboard: widget.isDirect),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  header(),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        LikeButton(
                          // size of the button
                          size: buttonSize,
                          // the total number of count
                          likeCount: likeCount,
                          // to handle the count behaviour
                          countBuilder: (int? count, bool isLiked, String text) {
                            // color of the count
                            final ColorSwatch<int> color = isLiked ? Colors.pinkAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                'love',
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                count! >= 1000 ? (count / 1000.0).toStringAsFixed(1) + 'k' : text,
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                          // position of the count you want to show(i.e. TOP,BOTTOM,RIGHT,LEFT)
                          countPostion: CountPostion.right,
                          // Animation for the count
                          likeCountAnimationType: likeCount < 1000
                              ? LikeCountAnimationType.all // the whole number will change
                              : LikeCountAnimationType.part,
                          // only the last digit will change
                          onTap: onLikeButtonTapped,
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.comment, color: Colors.grey)
                      ],
                    ),
                  ),
                  Divider(),
                  header(),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        LikeButton(
                          size: buttonSize,
                          circleColor: const CircleColor(start: Color(0xff63C5DA), end: Color(0xff1338BE)),
                          bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff0080FF), dotSecondaryColor: Color(0xff1034A6)),
                          likeBuilder: (bool isLiked) {
                            return Icon(Icons.thumb_up, color: isLiked ? Colors.blue : Colors.grey, size: buttonSize);
                          },
                          countPostion: CountPostion.right,
                          likeCount: 100,
                          countBuilder: (int? count, bool isLiked, String text) {
                            final ColorSwatch<int> color = isLiked ? Colors.blue : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text('love', style: TextStyle(color: color));
                            } else
                              result = Text(text, style: TextStyle(color: color));
                            return result;
                          },
                        ),
                        SizedBox(width: 10),
                        LikeButton(
                          size: buttonSize,
                          circleColor: const CircleColor(start: Color(0xff63C5DA), end: Color(0xff1338BE)),
                          bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff0080FF), dotSecondaryColor: Color(0xff1034A6)),
                          likeBuilder: (bool isLiked) {
                            return Icon(Icons.thumb_down, color: isLiked ? Colors.blue : Colors.grey, size: buttonSize);
                          },
                          countPostion: CountPostion.right,
                          likeCount: 100,
                          likeCountAnimationType: LikeCountAnimationType.all,
                          countBuilder: (int? count, bool isLiked, String text) {
                            final MaterialColor color = isLiked ? Colors.blue : Colors.grey;
                            Widget result;
                            print(text);
                            if (count == 0) {
                              result = Text(
                                'love',
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                text,
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                        ),
                        Container(margin: EdgeInsets.only(left: 10), child: Icon(Icons.comment, color: Colors.grey))
                      ],
                    ),
                  ),
                  Divider(),
                  header(),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            LikeButton(
                              size: buttonSize,
                              likeCount: likeCount,
                              countBuilder: (int? count, bool isLiked, String text) {
                                final ColorSwatch<int> color = isLiked ? Colors.pinkAccent : Colors.grey;
                                Widget result;
                                if (count == 0) {
                                  result = Text(
                                    'love',
                                    style: TextStyle(color: color),
                                  );
                                } else
                                  result = Text(
                                    count! >= 1000 ? (count / 1000.0).toStringAsFixed(1) + 'k' : text,
                                    style: TextStyle(color: color),
                                  );
                                return result;
                              },
                              countPostion: CountPostion.right,
                              likeCountAnimationType: likeCount < 1000 ? LikeCountAnimationType.all : LikeCountAnimationType.part,
                              onTap: onLikeButtonTapped,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.comment, color: Colors.grey),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 15),
                          child: LikeButton(
                            size: buttonSize,
                            circleColor: const CircleColor(
                              start: Color(0xff63C5DA),
                              end: Color(0xff1338BE),
                            ),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xff0080FF),
                              dotSecondaryColor: Color(0xff1034A6),
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.assistant_photo,
                                color: isLiked ? Colors.blue : Colors.grey,
                                size: buttonSize,
                              );
                            },
                            likeCount: 888,
                            countBuilder: (int? count, bool isLiked, String text) {
                              final ColorSwatch<int> color = isLiked ? Colors.blue : Colors.grey;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  'love',
                                  style: TextStyle(color: color),
                                );
                              } else
                                result = Text(
                                  text,
                                  style: TextStyle(color: color),
                                );
                              return result;
                            },
                            countPostion: CountPostion.right,
                            likeCountPadding: const EdgeInsets.only(left: 5.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}
