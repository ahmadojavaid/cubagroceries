import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_button.dart';
import '../../component/custom_texfield.dart';
import '../../resources/bottom_navigation.dart';
import '../../store/profile_store.dart';
import '../../utils/colors.dart';
import '../../utils/image.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileStore store = ProfileStore();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Use Brightness.dark if needed
        ),
        backgroundColor: scaffoldSecondaryDark,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: limeColor,
            size: 28,
          ),
          onPressed: () {
            hideKeyboard(context);
            finish(context);
          },
        ),
        title: Text("Back", style: primaryTextStyle(color: limeColor)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.12),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "Fill Your Profile",
                      style: boldTextStyle(size: 24, color: Colors.white),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Text(
                      "Complete your profile to get a customized fitness experience based on your details.",
                      style: secondaryTextStyle(size: 14, color: Colors.white54),
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 16),
                    SizedBox(height: screenHeight * 0.03),

                    Observer(
                      builder: (_) {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.15,
                              backgroundImage: store.selectedImage != null
                                  ? FileImage(store.selectedImage!) as ImageProvider
                                  //TODO:
                                  : AssetImage(profile),
                              backgroundColor: Colors.grey[800],
                            ),
                            GestureDetector(
                              onTap: () async {
                                await store.pickImage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: limeColor,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                   40.height,

                    // Profile Fields
                    buildProfileField("Full Name", "Full Name"),
                    buildProfileField("Nickname", "Nickname"),
                    buildProfileField("Email", "Email", icon: mailIcon),
                    buildProfileField(
                      "Mobile Number",
                      "Mobile Number",
                      icon: phoneIcon,
                    ),


               80.height
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.03,
                ),
                child: CustomButton(
                  color: limeColor,
                  textcolor: blackColor,
                  text: "Start",
                  onPressed: () {
                    hideKeyboard(context);
                    CustomBottomNavigation().launch(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String hint, {String? icon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: primaryTextStyle(color: Colors.white, size: 15)).paddingLeft(10),
          SizedBox(height: 5),
          CustomTextField(
            hintText: hint,
            imageIcon: icon,
          ),
        ],
      ),
    );
  }
}
