import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class ShowDialogBoxComponent extends StatelessWidget {
  const ShowDialogBoxComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: lottie var
          Lottie.asset(
           Images.img_lottie5,
            height: 200,
            reverse: true,
            repeat: true,
          ),
          const SizedBox(height: 16),
          const Text(SignInText.signSuccessful, style: TextStyle(fontSize: 30)),
          const SizedBox(height: 13),
          const Text(SignInText.pleaseWait),
          const Text(SignInText.directHome),
        ],
      ),
    );
  }
}
