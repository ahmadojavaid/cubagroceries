import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/my_app_bar.dart';
import '../../../store/gender_selection.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import 'package:prokit_flutter/main.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    super.initState();
    nameController.text = "Andrew Ainsley";
    nicknameController.text = "Andrew";
    _dateController.text = "17/9/2002";
    emailController.text = "andrew_ainsley@gmail.com";
    numberController.text = "9651514423";
  }

  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    nameController.dispose();
    nicknameController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: appStore.isDarkModeOn
              ? Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary:
                        primaryBlueColor, // header background color & selected date
                    onPrimary: lightColor, // text color on selected date
                    onSurface: lightColor, // default text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          primaryBlueColor, // button text color (OK, Cancel)
                    ),
                  ),
                )
              : Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary:
                        primaryBlueColor, // header background color & selected date
                    onPrimary: lightColor, // text color on selected date
                    onSurface: darkColor, // default text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          primaryBlueColor, // button text color (OK, Cancel)
                    ),
                  ),
                ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _dateController.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  final GenderSelection genderStore = GenderSelection();
  final List<String> _gender = ["Male", "Female", "Other"];

  TextEditingController nameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  ExpansionTileController expansionTileController = ExpansionTileController();

  Future pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    File imageTamp = File(image.path);
    setState(() {
      image = imageTamp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          16.height,
          Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                children: [
                  image == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(friend2),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.file(image),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: primaryBlueColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: lightColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          16.height,
          lableText("Name :"),
          12.height,
          profileNameTextField(nameController, "Name"),
          16.height,
          lableText("Nick Name :"),
          12.height,
          profileNameTextField(nicknameController, "Nickname"),
          16.height,
          lableText("Email :"),
          12.height,
          emailTextField(emailController, "Email", Icons.email, false),
          16.height,
          lableText("Date of Birth :"),
          12.height,
          emailTextField(_dateController, "Date of birth", Icons.calendar_month,
              true, () => _selectDate(context)),
          16.height,
          lableText("Phone Number :"),
          12.height,
          IntlPhoneField(
            controller: numberController,
            dropdownTextStyle: TextStyle(
              color: hintTextColor,
            ),
            pickerDialogStyle: PickerDialogStyle(
              backgroundColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
              countryCodeStyle: primaryTextStyle(),
              countryNameStyle: primaryTextStyle(),
            ),
            initialCountryCode: "IN",
            style: primaryTextStyle(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterStyle: TextStyle(
                color: hintTextColor,
              ),
              helperStyle: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 14),
              hintText: "000 0000 000",
              hintStyle: TextStyle(color: hintTextColor),
              filled: true,
              fillColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryBlueColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          lableText("Gender :"),
          12.height,
          Card(
            elevation: 00,
            color: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  controller: expansionTileController,
                  backgroundColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
                  title: Observer(
                    builder: (_) {
                      return Text(
                        genderStore.selectedGender,
                        style: TextStyle(
                            color: genderStore.selectedGender == "Gender"
                                ? hintTextColor
                                : appStore.isDarkModeOn
                                    ? lightColor
                                    : darkColor),
                      );
                    },
                  ),
                  children: [
                    GestureDetector(
                      onTap: () {
                        genderStore.selectedGender = _gender[0];
                        expansionTileController.collapse();
                      },
                      child: ListTile(
                        title: Text(_gender[0], style: primaryTextStyle()),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        genderStore.selectedGender = _gender[1];
                        expansionTileController.collapse();
                      },
                      child: ListTile(
                        title: Text(_gender[1], style: primaryTextStyle()),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        genderStore.selectedGender = _gender[2];
                        expansionTileController.collapse();
                      },
                      child: ListTile(
                        title: Text(_gender[2], style: primaryTextStyle()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ).paddingSymmetric(horizontal: 14),
          16.height,
          AppButton(
            text: 'Update',
            color: primaryBlueColor,
            textStyle: boldTextStyle(color: Colors.white),
            width: context.width(),
            shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
            onTap: () {
              nameController.clear();
              nicknameController.clear();
              emailController.clear();
              _dateController.clear();
              numberController.clear();
              hideKeyboard(context);
              finish(context);
            },
          ).paddingSymmetric(horizontal: 16),
          50.height,
        ]),
      ),
    );
  }

  Widget profileNameTextField(
      TextEditingController controller, String hintText) {
    return AppTextField(
            textStyle: primaryTextStyle(),
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
                hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlueColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText),
            textFieldType: TextFieldType.USERNAME)
        .paddingSymmetric(horizontal: 16);
  }

  Widget emailTextField(TextEditingController controller, String hintText,
      IconData iconData, bool read,
      [VoidCallback? voidCallBack]) {
    return AppTextField(
            textStyle: primaryTextStyle(),
            controller: controller,
            readOnly: read,
            onTap: voidCallBack,
            decoration: InputDecoration(
                suffixIconColor: hintTextColor,
                suffixIcon: Icon(iconData),
                filled: true,
                fillColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
                hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryBlueColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText),
            textFieldType: TextFieldType.EMAIL)
        .paddingSymmetric(horizontal: 16);
  }

  Widget lableText(String text) {
    return Text(
      text,
      style: boldTextStyle(),
    ).paddingSymmetric(horizontal: 16);
  }
}
