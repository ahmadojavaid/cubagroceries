import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

var lastBackPressTime = 0;

bool onWillPop(BuildContext context) {
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  if (currentTime - lastBackPressTime < 2000) {
    return true;
  } else {
    lastBackPressTime = currentTime;
    Fluttertoast.showToast(msg: "Press Back Again to Exit", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: blackColor, textColor: context.cardColor, fontSize: 16.0);
    return false;
  }
}
