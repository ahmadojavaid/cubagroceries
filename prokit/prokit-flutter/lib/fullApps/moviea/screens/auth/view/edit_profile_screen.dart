import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/images.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _image!,
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                userImg,
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showPicker(context),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                              ),
                              child: const Center(
                                child: Icon(Icons.edit, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 16),
                ),
                Container(
                  height: 50,
                  width: context.width(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ).paddingOnly(top: 10),
                ).paddingOnly(top: 20, left: 16, right: 16),
                Container(
                  height: 50,
                  width: context.width(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ).paddingOnly(top: 10),
                ).paddingOnly(top: 16, left: 16, right: 16),
                Container(
                  height: 50,
                  width: context.width(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Address',
                      labelStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ).paddingOnly(top: 10),
                ).paddingOnly(top: 16, left: 16, right: 16),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: context.width(),
              color: Colors.red,
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              onTap: () async {
                finish(context);
              },
              child: Text("Update", style: boldTextStyle(size: 18, color: Colors.white), textAlign: TextAlign.start),
            ),
          )
        ],
      ),
    );
  }
}
