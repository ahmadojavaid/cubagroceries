import '../../../../utils/images.dart';

class NotificationModel {
  String? icon;
  String? title;
  String? subtitle;

  NotificationModel({this.icon, this.title, this.subtitle});
}

List<NotificationModel> getTodayList() {
  List<NotificationModel> tempBranchList = [];

  tempBranchList.add(
    NotificationModel(
      icon: settingIcon,
      title: "Get 30% off on Dance Event!",
      subtitle: "Special promotion only valid today",
    ),
  );

  tempBranchList.add(
    NotificationModel(
      icon: lockIcon,
      title: "Password Update Successful",
      subtitle: "Your Password Update Successfully",
    ),
  );

  return tempBranchList;
}

List<NotificationModel> getyestrdayList() {
  List<NotificationModel> afternoonBranchList = [];

  afternoonBranchList.add(
    NotificationModel(
      icon: userIcon,
      title: "Account Setup Successful!",
      subtitle: "Your account has been create",
    ),
  );

  afternoonBranchList.add(
    NotificationModel(
      icon: boxIcon,
      title: "Redeem your gift cart",
      subtitle: "You have get one gift car",
    ),
  );

  afternoonBranchList.add(
    NotificationModel(
      icon: debitIcon,
      title: "Debit card added Successfully",
      subtitle: "Your Debit card added Successfully",
    ),
  );

  return afternoonBranchList;
}
