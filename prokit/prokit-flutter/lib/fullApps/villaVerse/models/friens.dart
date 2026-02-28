// ignore_for_file: file_names

import '../utils/image.dart';

class Friends {
  final String imagePath;
  final String name;
  final String number;
  bool isInvited;

  Friends({required this.imagePath, required this.name, required this.number, this.isInvited = false});
}

List<Friends> getFriendsList() {
  List<Friends> friends = [];
  friends.add(Friends(imagePath: friend1, name: "Emma Johnson", number: "(312) 764-8902"));
  friends.add(Friends(imagePath: friend2, name: "Noah Anderson", number: "(415) 832-1945"));
  friends.add(Friends(imagePath: friend3, name: "Liam Davis", number: "(646) 521-3087"));
  friends.add(Friends(imagePath: friend4, name: "Ava Thompson", number: "(305) 779-6654"));
  friends.add(Friends(imagePath: friend5, name: "Elijah Robinson", number: "(704) 301-1198"));
  friends.add(Friends(imagePath: friend8, name: "Isabella Lewis", number: "(617) 429-7762"));
  friends.add(Friends(imagePath: friend2, name: "James Walker", number: "(213) 882-5509"));
  friends.add(Friends(imagePath: friend8, name: "John Walker", number: "(213) 882-5509"));
  friends.add(Friends(imagePath: friend1, name: "Benjamin Clark", number: "(469) 270-3383"));
  friends.add(Friends(imagePath: friend1, name: "Emma Johnson", number: "(312) 764-8902"));
  friends.add(Friends(imagePath: friend2, name: "Noah Anderson", number: "(415) 832-1945"));
  friends.add(Friends(imagePath: friend3, name: "Liam Davis", number: "(646) 521-3087"));
  friends.add(Friends(imagePath: friend4, name: "Ava Thompson", number: "(305) 779-6654"));
  friends.add(Friends(imagePath: friend5, name: "Elijah Robinson", number: "(704) 301-1198"));
  friends.add(Friends(imagePath: friend1, name: "Isabella Lewis", number: "(617) 429-7762"));
  friends.add(Friends(imagePath: friend3, name: "James Walker", number: "(213) 882-5509"));
  friends.add(Friends(imagePath: friend8, name: "John Walker", number: "(213) 882-5509"));
  friends.add(Friends(imagePath: friend1, name: "Benjamin Clark", number: "(469) 270-3383"));

  return friends;
}
