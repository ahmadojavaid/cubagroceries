import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../models/chat_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';

class CallList extends StatelessWidget {
  const CallList({super.key});

  Icon _getCallIcon(ChatModel call) {
    if (call.isVideoCall == true) {
      return Icon(
        call.isMissedCall == true ? Icons.videocam_off : Icons.videocam,
        color: call.isMissedCall == true ? Colors.red : primaryBlueColor,
      );
    } else {
      return Icon(
        call.isMissedCall == true ? Icons.call_missed : Icons.call,
        color: call.isMissedCall == true ? Colors.red : primaryBlueColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: callList.length,
      itemBuilder: (context, index) {
        final call = callList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(call.imageUrl),
          ),
          title: Text(
            call.senderName,
          ),
          subtitle: Text('${call.message} • ${call.timestamp}',
              style: TextStyle(color: hintTextColor)),
          trailing: _getCallIcon(call),
        ).paddingOnly(bottom: index == callList.length - 1 ? 70 : 0);
      },
    );
  }
}
