import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../component/my_app_bar.dart';
import '../../../store/gender_selection.dart';
import '../../../utils/colors.dart';
import 'book_real_estate_payment_selection.dart';
import 'bookingComponents/title_text.dart';

class BookRealeEstateInformationScreen extends StatefulWidget {
  const BookRealeEstateInformationScreen({super.key});

  @override
  State<BookRealeEstateInformationScreen> createState() =>
      _BookRealeEstateInformationScreenState();
}

class _BookRealeEstateInformationScreenState
    extends State<BookRealeEstateInformationScreen> {
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
      firstDate: DateTime(2000),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Book Real Estate'),
      body: ListView(
        children: [
          16.height,
          TitleText(text: "Your Information Details"),
          16.height,
          16.height,
          profileNameTextField(nameController, "Name"),
          16.height,
          profileNameTextField(nicknameController, "Nickname"),
          16.height,
          emailTextField(emailController, "Email", Icons.email, false),
          16.height,
          emailTextField(_dateController, "Date of birth", Icons.calendar_month,
              true, () => _selectDate(context)),
          16.height,
          IntlPhoneField(
            controller: numberController,
            dropdownTextStyle: TextStyle(
              color: hintTextColor,
            ),
            pickerDialogStyle: PickerDialogStyle(
              backgroundColor: appStore.isDarkModeOn
                  ? inputFillColorDart
                  : inputFillColorlight,
              countryCodeStyle: secondaryTextStyle(),
              countryNameStyle: secondaryTextStyle(),
            ),
            initialCountryCode: "IN",
            style: secondaryTextStyle(
                color: appStore.isDarkModeOn ? lightColor : darkColor),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterStyle: TextStyle(
                color: hintTextColor,
              ),
              helperStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 14),
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
          Card(
            elevation: 00,
            color: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  controller: expansionTileController,
                  backgroundColor: appStore.isDarkModeOn ? inputFillColorDart :inputFillColorlight,
                  title: Observer(builder: (_) {
                    return Text(
                      genderStore.selectedGender,
                      style: TextStyle(
                        color: genderStore.selectedGender == "Gender"
                            ? hintTextColor
                            : appStore.isDarkModeOn
                                ? lightColor
                                : darkColor,
                      ),
                    );
                  }),
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
            text: 'Continue',
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
              BookRealEstatePaymentSelection().launch(
                context,
              );
            },
          ).paddingSymmetric(horizontal: 16)
        ],
      ),
    );
  }

  Widget profileNameTextField(
      TextEditingController controller, String hintText) {
    return AppTextField(
            textStyle: secondaryTextStyle(
                color: appStore.isDarkModeOn ? lightColor : darkColor),
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
            textStyle: secondaryTextStyle(
                color: appStore.isDarkModeOn ? lightColor : darkColor),
            controller: controller,
            suffixIconColor: hintTextColor,
            readOnly: read,
            onTap: voidCallBack,
            decoration: InputDecoration(
                suffixIcon: Icon(iconData),
                suffixIconColor: hintTextColor,
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
}
