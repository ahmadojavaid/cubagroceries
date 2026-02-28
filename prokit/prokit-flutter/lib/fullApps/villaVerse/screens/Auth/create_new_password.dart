// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/my_app_bar.dart';
import '../../utils/colors.dart';
import '../../../../main.dart';
import '../../utils/image.dart';
import '../Home/homeScreenActions/components/bottom_navigation.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  Future showMsg() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          icon: Column(
            children: [
              Lottie.asset(checkDoneAnimation, repeat: false),
              SizedBox(height: 15),
              Text(
                "Congratulations!",
                style: TextStyle(fontSize: 20, color: primaryBlueColor),
              ),
              SizedBox(height: 15),
              Text(
                  "Your account is ready to use you will be redirected to the home page in a few seconds",
                  textAlign: TextAlign.center),
              SizedBox(height: 15),
              SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryBlueColor,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Create new password'),
      body: SafeArea(
        child: ListView(
          children: [
            Image.network(createNewPassword),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Create Your New Password"),
            ),
            20.height,
            textField('New Password', passwordController),
            20.height,
            textField('Confirm Password', conformPasswordController),
            30.height,
            SizedBox(height: 15),
            AppButton(
              text: 'Continue',
              color: primaryBlueColor,
              textStyle: boldTextStyle(color: lightColor),
              width: context.width(),
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
              onTap: () async {
                showMsg();
                await Future.delayed(3.seconds);
                BottomNavigation().launch(context);
              },
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }

  Widget textField(String hintText, TextEditingController controller) {
    return AppTextField(
      textStyle: primaryTextStyle(),
      controller: controller,
      isPassword: true,
      suffixIconColor: hintTextColor,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: hintTextColor),
          filled: true,
          fillColor:
              appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
          hintStyle: TextStyle(color: hintTextColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryBlueColor),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText),
      textFieldType: TextFieldType.PASSWORD,
    ).paddingSymmetric(horizontal: 16);
  }
}
