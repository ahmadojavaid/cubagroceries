import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';

class TermsAndConditionsCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool initialValue;

  const TermsAndConditionsCheckbox({
    Key? key,
    required this.onChanged,
    this.initialValue = false,
  }) : super(key: key);

  @override
  _TermsAndConditionsCheckboxState createState() => _TermsAndConditionsCheckboxState();
}

class _TermsAndConditionsCheckboxState extends State<TermsAndConditionsCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: _isChecked, onChanged: _toggleCheckbox),
        Expanded(
          child: GestureDetector(
            onTap: () => _toggleCheckbox(!_isChecked),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'I agree to the ',
                    style: TextStyle(
                      color: appStore.isDarkModeOn ? whiteColor : black,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(
                      color: stayNestPrimaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
