import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/common_base.dart';

class AddReviewScreen extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String types;
  final String duration;
  final String rating;

  const AddReviewScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.types,
    required this.duration,
    required this.rating,
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  ScrollController scrollController = ScrollController();

  late String _receivedImage;
  late String _receivedTitle;
  late String _receivedSubtitle;
  late String _receivedRating;

  @override
  void initState() {
    super.initState();
    _receivedImage = widget.image;
    _receivedTitle = widget.title;
    _receivedSubtitle = widget.subtitle;
    _receivedRating = widget.rating;
  }

  List<bool> isSelected = List.generate(5, (_) => false);

  void onStarTap(int index) {
    setState(() {
      for (int i = 0; i <= index; i++) {
        isSelected[i] = true;
      }
      for (int i = index + 1; i < isSelected.length; i++) {
        isSelected[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: context.height() * 0.65,
        child: Stack(fit: StackFit.expand, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Leave a Review",
                  style: boldTextStyle(size: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              8.height,
              Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please share your valuable review",
                      style: secondaryTextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ).expand(),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: NetworkImage(_receivedImage), fit: BoxFit.cover),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _receivedTitle,
                              style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _receivedSubtitle,
                              style: secondaryTextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).paddingOnly(top: 10),
                            Text(
                              _receivedRating,
                              style: const TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).paddingOnly(top: 10),
                          ],
                        ).paddingOnly(left: 16).expand(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: boxDecorationDefault(color: Colors.grey.shade100, boxShadow: [const BoxShadow(color: Colors.transparent)]),
                          child: const Text("Paid"),
                        ).paddingOnly(right: 10, left: 16),
                      ],
                    ),
                  ],
                ),
              ),
              16.height,
              const Center(child: Text("Please give your rating with us")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    GestureDetector(
                      onTap: () => onStarTap(i),
                      child: Icon(
                        Icons.star,
                        color: isSelected[i] ? Colors.amber : Colors.grey,
                      ),
                    ),
                ],
              ).paddingOnly(top: 5),
              30.height,
              AppTextField(
                textStyle: primaryTextStyle(size: 12),
                textFieldType: TextFieldType.MULTILINE,
                isValidationRequired: false,
                minLines: 5,
                decoration: inputDecoration(context, label: "Add a comment"),
                onTap: () {
                  scrollController.animToBottom(milliseconds: 300);
                  setState(() {});
                },
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  elevation: 0,
                  color: Colors.white,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  onTap: () async {
                    finish(context);
                  },
                  child: Text("Cancel", style: boldTextStyle(color: Colors.black)),
                ).expand(),
                16.width,
                AppButton(
                  elevation: 0,
                  color: Colors.red,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.red),
                  ),
                  onTap: () async {
                    finish(context);
                  },
                  child: Text("Submit", style: boldTextStyle(color: Colors.white)),
                ).expand(),
              ],
            ),
          )
        ]),
      ).paddingAll(16),
    );
  }
}
