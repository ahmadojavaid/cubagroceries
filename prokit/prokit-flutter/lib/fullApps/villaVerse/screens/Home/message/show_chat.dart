import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../models/chat_model.dart';
import '../../../utils/colors.dart';
import 'call_screen.dart';

class ShowChat extends StatefulWidget {
  final ChatModel chat;

  const ShowChat({super.key, required this.chat});

  @override
  State<ShowChat> createState() => _ShowChatState();
}

class _ShowChatState extends State<ShowChat> {
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: "Hello, good afternoon too Andrew... 😊",
      isSentByMe: false,
      time: "16:01",
    ),
    _ChatMessage(
      text: "Of course, the apartment is always open anytime",
      isSentByMe: false,
      time: "16:01",
    ),
    _ChatMessage(
      text: "I want to book your apartment for 5 days. Can it?",
      isSentByMe: true,
      time: "16:00",
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        leadingWidth: 40,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: appStore.isDarkModeOn ? lightColor : darkColor),
          onPressed: () => finish(context),
        ).paddingOnly(left: 16),
        title: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(widget.chat.imageUrl),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.chat.senderName,
                style: boldTextStyle(size: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call,
                color: appStore.isDarkModeOn ? lightColor : darkColor),
            onPressed: () {
              hideKeyboard(context);
              CallScreen().launch(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam,
                color: appStore.isDarkModeOn ? lightColor : darkColor),
            onPressed: () {},
          ).paddingOnly(right: 16),
        ],
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedListView(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[_messages.length - 1 - index];
                  return Align(
                    alignment: msg.isSentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      decoration: BoxDecoration(
                        color: msg.isSentByMe
                            ? primaryBlueColor
                            : appStore.isDarkModeOn
                                ? inputFillColorDart
                                : inputFillColorlight,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: msg.isSentByMe
                              ? Radius.circular(12)
                              : Radius.circular(0),
                          bottomRight: msg.isSentByMe
                              ? Radius.circular(0)
                              : Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isSentByMe
                                  ? lightColor
                                  : appStore.isDarkModeOn
                                      ? lightColor
                                      : darkColor,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                msg.time,
                                style: TextStyle(
                                  color: msg.isSentByMe
                                      ? lightColor
                                      : appStore.isDarkModeOn
                                          ? lightColor
                                          : darkColor,
                                  fontSize: 11,
                                ),
                              ),
                              if (msg.isSentByMe && msg.isRead != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    msg.isRead! ? Icons.done_all : Icons.done,
                                    size: 14,
                                    color: msg.isRead!
                                        ? blueLight
                                        : Colors.white70,
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Row(
      children: [
        Expanded(
            child: AppTextField(
                textStyle: primaryTextStyle(),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.emoji_emotions_outlined,
                        color: primaryBlueColor),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attach_file, color: primaryBlueColor),
                        10.width,
                        Icon(
                          Icons.camera_alt,
                          color: primaryBlueColor,
                        )
                      ],
                    ).paddingOnly(right: 10),
                    filled: true,
                    fillColor: appStore.isDarkModeOn
                        ? inputFillColorDart
                        : inputFillColorlight,
                    hintStyle: TextStyle(color: hintTextColor, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryBlueColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Type a message"),
                textFieldType: TextFieldType.USERNAME)),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: primaryBlueColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.mic, color: lightColor),
            onPressed: () {},
          ),
        )
      ],
    ).paddingAll(16);
  }
}

class _ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;
  final bool? isRead;

  _ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.isRead,
  });
}
