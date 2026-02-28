import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/dating/screen/DAIdealScreen.dart';
import 'package:prokit_flutter/fullApps/dating/utils/DAColors.dart';

class DAUploadPhotoScreen extends StatefulWidget {
  @override
  DAUploadPhotoScreenState createState() => DAUploadPhotoScreenState();
}

class DAUploadPhotoScreenState extends State<DAUploadPhotoScreen> {
  List<XFile> images = <XFile>[];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> loadAssets() async {
    try {
      final List<XFile> selectedImages = await _picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        setState(() {
          if (images.length + selectedImages.length <= 4) {
            images.addAll(selectedImages);
          } else {
            int remainingSlots = 4 - images.length;
            images.addAll(selectedImages.take(remainingSlots));
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('apes', titleTextStyle: boldTextStyle(size: 25), color: context.cardColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text('Upload your \nPhoto', style: boldTextStyle(size: 30)),
            16.height,
            Text('Add your best photos', style: primaryTextStyle()),
            16.height,
            images.isNotEmpty
                ? Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                images.length,
                    (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(images[index].path),
                      height: 200,
                      width: 155,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            )
                : uploadImage(),
            16.height,
            AppButton(
              width: context.width(),
              color: primaryColor,
              onTap: () {
                DAIdealScreen().launch(context);
              },
              text: 'Continue',
              textStyle: boldTextStyle(color: white),
            ),
            16.height,
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }

  Widget uploadImage() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(
        4,
            (index) {
          return DottedBorderWidget(
            radius: 10,
            padding: EdgeInsets.zero,
            color: primaryColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor.withOpacity(0.2),
              ),
              height: 200,
              width: context.width() * 0.5 - 24,
              child: IconButton(
                onPressed: () {
                  loadAssets();
                },
                icon: Icon(Icons.add, color: primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}