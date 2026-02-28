import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/constant.dart';
import '../show_chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final chat = chatList[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(chat.imageUrl),
              ),
            ),
          ),
          title: Text(
            chat.senderName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            chat.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formatChatTime(chat.timestamp),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 4),
              if (!chat.isSentByUser) // Unread badge condition
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '3', // Example unread count
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
          onTap: () => ShowChat(chat: chat).launch(
            context,
          ),
        ).paddingOnly(bottom: index == chatList.length - 1 ? 70 : 0);
      },
    );
  }

  String _formatChatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    if (difference.inDays == 0) {
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else {
      return "${time.month}/${time.day}/${time.year}";
    }
  }
}
