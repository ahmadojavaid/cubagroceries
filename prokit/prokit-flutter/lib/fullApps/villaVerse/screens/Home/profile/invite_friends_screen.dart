import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../component/my_app_bar.dart';
import '../../../models/friens.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Invite Friends'),
      body: AnimatedListView(
        itemCount: inviteFriendsList.length,
        itemBuilder: (context, index) {
          Friends data = inviteFriendsList[index];
          return ListTile(
            onTap: () {
              data.isInvited = !data.isInvited;
              inviteFriendStore.toggleInviteFriend(data);
            },
            leading: SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(data.imagePath),
                ),
              ),
            ),
            title: Text(
              data.name,
              style: boldTextStyle(size: 16),
            ),
            subtitle: Text(
              data.number,
              style: primaryTextStyle(),
            ),
            trailing: Observer(builder: (_) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: primaryBlueColor),
                ),
                color: inviteFriendStore.inviteFriends.contains(data)
                    ? appStore.isDarkModeOn
                        ? darkColor
                        : lightColor
                    : primaryBlueColor,
                child: Text(
                  inviteFriendStore.inviteFriends.contains(data)
                      ? "Invited"
                      : "Invite",
                  style: TextStyle(
                      color: inviteFriendStore.inviteFriends.contains(data)
                          ? primaryBlueColor
                          : lightColor),
                ).paddingSymmetric(horizontal: 16, vertical: 5),
              );
            }),
          ).paddingOnly(bottom: index == inviteFriendsList.length - 1 ? 70 : 0);
        },
      ),
    );
  }
}
