import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/driver_information/screen/video_with_driver_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import 'call_with_driver_screen.dart';

class ChatWithDriverScreen extends StatefulWidget {
  const ChatWithDriverScreen({super.key});

  @override
  _ChatWithDriverScreenState createState() => _ChatWithDriverScreenState();
}

class _ChatWithDriverScreenState extends State<ChatWithDriverScreen> {
  bool showEmoji = false;
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  List<Map<String, String>> messages = [
    {"message": "Hello, good morning Andrew...😁", "sender": "driver", "time": "09:41"},
    {"message": "I'm Rayford, I'll be right over and take your order. Please wait...⏳😁", "sender": "driver", "time": "09:42"},
    {"message": "Hello Rayford, ok I will be waiting for you in front of my house. You can notify me when it arrives...😀", "sender": "user", "time": "09:41"},
    {"message": "Great! I will arrive soon 🔥", "sender": "driver", "time": "09:41"},
  ];

  void _toggleEmojiKeyboard() {
    if (showEmoji) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
    setState(() {
      showEmoji = !showEmoji;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rayford Chenail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CallWithDriverScreen()),
              );
            },
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VideoWithDriverScreen()),
              );
            },
            icon: const Icon(Icons.video_call_outlined),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            showEmoji = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isDriverMessage = message['sender'] == 'driver';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: isDriverMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDriverMessage ? Colors.grey[300] : PickColor.brownColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: isDriverMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                              children: [
                                Text(
                                  style: TextStyle(color: isDriverMessage ? Colors.black : Colors.white),
                                  message['message']!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      message['time']!,
                                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (!isDriverMessage) ...[
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: const DecorationImage(
                                      image: NetworkImage(Images.img_home1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: const DecorationImage(
                                      image: NetworkImage(Images.img_home2),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text input field and emoji toggle button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  onTap: () {
                    if (showEmoji) {
                      setState(() {
                        showEmoji = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: _toggleEmojiKeyboard,
                      icon: Icon(showEmoji ? Icons.keyboard : Icons.emoji_emotions_outlined),
                    ),
                    hintText: "Type a message",
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.attachment),
                    ),
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: PickColor.brownColor,
                ),
                child: const Center(
                  child: Icon(Icons.send, color: PickColor.whiteColor),
                ),
              )
            ],
          ),
        ),
        // Emoji picker
        Offstage(
          offstage: !showEmoji,
          child: SizedBox(
            height: 300,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _textController.text += emoji.emoji;
              },
              config: Config(
                height: 256,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(emojiSizeMax: 25 * (Platform.isIOS ? 1.20 : 1.0)),
                viewOrderConfig: const ViewOrderConfig(
                  top: EmojiPickerItem.categoryBar,
                  middle: EmojiPickerItem.emojiView,
                  bottom: EmojiPickerItem.searchBar,
                ),
                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(),
                searchViewConfig: const SearchViewConfig(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
