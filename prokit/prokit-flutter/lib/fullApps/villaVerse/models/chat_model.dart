import '../utils/image.dart';

class ChatModel {
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isSentByUser;
  final String imageUrl;

  // Optional fields for call data
  final bool? isCall;
  final bool? isVideoCall;
  final bool? isMissedCall;

  ChatModel({
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isSentByUser,
    required this.imageUrl,
    this.isCall,
    this.isVideoCall,
    this.isMissedCall,
  });
}

List<ChatModel> getChatList() {
  List<ChatModel> chats = [];

  chats.add(
    ChatModel(
      senderName: "Emma Johnson",
      message: 'Hey there! Are you free this evening?',
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      isSentByUser: false,
      imageUrl: friend1,
    ),
  );
  chats.add(
    ChatModel(
      senderName: "Noah Anderson",
      message: 'Yes, I am. What’s up?',
      timestamp: DateTime.now().subtract(Duration(minutes: 12)),
      isSentByUser: true,
      imageUrl: friend5,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Alice',
      message: 'Let’s catch up at the cafe downtown.',
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      isSentByUser: false,
      imageUrl: friend1,
    ),
  );
  chats.add(
    ChatModel(
      senderName: "Liam Davis",
      message: 'Sounds good! See you at 6.',
      timestamp: DateTime.now().subtract(Duration(minutes: 8)),
      isSentByUser: true,
      imageUrl: friend2,
    ),
  );
  chats.add(
    ChatModel(
      senderName: "Ava Thompson",
      message: 'Also, check out this pic from last weekend!',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isSentByUser: false,
      imageUrl: friend3,
    ),
  );
  chats.add(
    ChatModel(
      senderName: "Elijah Robinson",
      message: 'Hey there! Are you free this evening?',
      timestamp: DateTime.now().subtract(Duration(minutes: 25)),
      isSentByUser: false,
      imageUrl: friend4,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Isabella Lewis',
      message: 'Yes, I am. What’s up?',
      timestamp: DateTime.now().subtract(Duration(minutes: 23)),
      isSentByUser: true,
      imageUrl: friend5,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'James Walker',
      message: 'Let’s catch up at the cafe downtown.',
      timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      isSentByUser: false,
      imageUrl: friend1,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'John Walker',
      message: 'Sounds good! See you at 6 ☕',
      timestamp: DateTime.now().subtract(Duration(minutes: 18)),
      isSentByUser: true,
      imageUrl: friend3,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Benjamin Clark',
      message: 'Also, check out this pic from last weekend!',
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      isSentByUser: false,
      imageUrl: friend8,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Emma Johnson',
      message: 'Meeting rescheduled to tomorrow 10 AM.',
      timestamp: DateTime.now().subtract(Duration(minutes: 13)),
      isSentByUser: false,
      imageUrl: friend5,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Noah Anderson',
      message: 'Got it. Thanks for the heads-up!',
      timestamp: DateTime.now().subtract(Duration(minutes: 12)),
      isSentByUser: true,
      imageUrl: friend4,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Charlie',
      message: 'Check this meme 😂',
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      isSentByUser: false,
      imageUrl: friend2,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Liam Davis',
      message: 'LOL that made my day!',
      timestamp: DateTime.now().subtract(Duration(minutes: 8)),
      isSentByUser: true,
      imageUrl: friend2,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Ava Thompson',
      message: 'Happy Birthday! 🎉🎂',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isSentByUser: false,
      imageUrl: friend3,
    ),
  );
  chats.add(
    ChatModel(
      senderName: 'Elijah Robinson',
      message: 'Thanks a lot, Diana! 😊',
      timestamp: DateTime.now().subtract(Duration(minutes: 3)),
      isSentByUser: true,
      imageUrl: friend1,
    ),
  );
  return chats;
}

List<ChatModel> getCallList() {
  List<ChatModel> calls = [];

  calls.add(
    ChatModel(
      senderName: "Emma Johnson",
      message: "Missed voice call",
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isSentByUser: false,
      imageUrl: friend1,
      isCall: true,
      isVideoCall: false,
      isMissedCall: true,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Noah Anderson",
      message: "Outgoing video call",
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      isSentByUser: true,
      imageUrl: friend5,
      isCall: true,
      isVideoCall: true,
      isMissedCall: false,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Liam Davis",
      message: "Incoming voice call",
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      isSentByUser: false,
      imageUrl: friend2,
      isCall: true,
      isVideoCall: false,
      isMissedCall: false,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Ava Thompson",
      message: "Missed video call",
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      isSentByUser: false,
      imageUrl: friend3,
      isCall: true,
      isVideoCall: true,
      isMissedCall: true,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Isabella Lewis",
      message: "Outgoing voice call",
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      isSentByUser: true,
      imageUrl: friend5,
      isCall: true,
      isVideoCall: false,
      isMissedCall: false,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "James Walker",
      message: "Incoming video call",
      timestamp: DateTime.now().subtract(Duration(hours: 3)),
      isSentByUser: false,
      imageUrl: friend3,
      isCall: true,
      isVideoCall: true,
      isMissedCall: false,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "John Walker",
      message: "Missed voice call",
      timestamp: DateTime.now().subtract(Duration(hours: 4, minutes: 10)),
      isSentByUser: false,
      imageUrl: friend1,
      isCall: true,
      isVideoCall: false,
      isMissedCall: true,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Benjamin Clark",
      message: "Outgoing video call",
      timestamp: DateTime.now().subtract(Duration(hours: 5)),
      isSentByUser: true,
      imageUrl: friend8,
      isCall: true,
      isVideoCall: true,
      isMissedCall: false,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Charlie",
      message: "Incoming voice call",
      timestamp: DateTime.now().subtract(Duration(hours: 6)),
      isSentByUser: false,
      imageUrl: friend2,
      isCall: true,
      isVideoCall: false,
      isMissedCall: false,
    ),
  );

  calls.add(
    ChatModel(
      senderName: "Diana Parker",
      message: "Missed video call",
      timestamp: DateTime.now().subtract(Duration(hours: 6, minutes: 30)),
      isSentByUser: false,
      imageUrl: friend4,
      isCall: true,
      isVideoCall: true,
      isMissedCall: true,
    ),
  );

  return calls;
}
