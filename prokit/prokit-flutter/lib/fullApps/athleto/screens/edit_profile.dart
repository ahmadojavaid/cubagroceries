import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../component/custom_button.dart';
import '../component/custom_texfield.dart';
import '../store/profile_store.dart';
import '../utils/colors.dart';
import '../utils/image.dart';

class EditUserDetailScreen extends StatelessWidget {
  final ProfileStore store = ProfileStore();

  EditUserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              color: primaryColor,
                              height: 280,
                              width: context.width(),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenWidth * 0.045),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_back,
                                              color: limeColor, size: 34)
                                              .onTap(() {
                                            hideKeyboard(context);
                                            finish(context);
                                          }),
                                          5.width,
                                          Text(
                                            'My Profile',
                                            style: boldTextStyle(
                                                color: Colors.white, size: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).paddingSymmetric(horizontal: 16),
                                  4.height,
                                  Observer(
                                    builder: (context) => Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          decoration: boxDecorationDefault(
                                            border: Border.all(
                                                color: primaryColor, width: 2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(4),
                                            child: CircleAvatar(
                                                radius: 55,
                                                backgroundImage:
                                                store.selectedImage != null
                                                    ? FileImage(store
                                                    .selectedImage!)
                                                as ImageProvider
                                                    : AssetImage(profile)),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 8,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(6),
                                            decoration: boxDecorationDefault(
                                              shape: BoxShape.circle,
                                              color: primaryColor,
                                              border: Border.all(
                                                  width: 2, color: white),
                                            ),
                                            child: Icon(Icons.edit,
                                                color: white, size: 18),
                                          ).onTap(
                                                () async {
                                              await store.pickImage();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  4.height,
                                  Marquee(
                                      child: Text("Madison Smith",
                                          style:
                                          boldTextStyle(color: white)))
                                      .paddingSymmetric(horizontal: 16),
                                  // 4.height,
                                  Marquee(
                                    child: Text("madisons@example.com",
                                        style: secondaryTextStyle(
                                            color: white.withValues(alpha: 0.8),
                                            size: 14)),
                                  ).paddingSymmetric(horizontal: 16),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -50,
                              left: 0,
                              right: 0,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 28),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 20),
                                decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: purpleColor),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    profileStat('75 Kg', 'Weight', screenWidth),
                                    verticalDivider(),
                                    profileStat('28', 'Years Old', screenWidth),
                                    verticalDivider(),
                                    profileStat(
                                        '1.65 CM', 'Height', screenWidth),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        buildProfileField(
                            "Full Name", "Email", mailIcon, context),
                        SizedBox(height: 20),
                        buildProfileField("Email or Mobile Number",
                            "Mobile Number", phoneIcon, context),
                        SizedBox(height: 20),
                        buildProfileField("Password", "Password", null, context,
                            isPassword: true),
                        SizedBox(height: 20),
                        buildProfileField("Confirm Password",
                            "Confirm Password", null, context,
                            isPassword: true),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.03),
                child: CustomButton(
                  text: "Update Profile",
                  color: limeColor,
                  textcolor: blackColor,
                  onPressed: () {
                    hideKeyboard(context);
                    finish(context);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget buildProfileField(
      String label, String hint, String? icon, BuildContext context,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: primaryTextStyle(color: purpleColor, size: 16)),
        SizedBox(height: 6),
        CustomTextField(
          hintText: hint,
          imageIcon: icon,
          isPassword: isPassword,
          textFieldType:
          isPassword ? TextFieldType.PASSWORD : TextFieldType.NAME,
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget profileStat(String value, String label, double screenWidth) {
    return Column(
      children: [
        Text(value, style: boldTextStyle(color: limeColor, size: 18)),
        Text(label, style: primaryTextStyle(color: Colors.white54, size: 16)),
      ],
    );
  }

  Widget verticalDivider() {
    return Container(
      height: 40,
      width: 5,
      decoration: boxDecorationDefault(color: whiteColor),
    );
  }


}
