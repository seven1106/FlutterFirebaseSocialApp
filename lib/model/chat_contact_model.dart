class ChatContactModel {
  final String name;
  final String profilePic;
  final String contactId;
  final String token;
  final DateTime timeSent;
  final String lastMessage;
  final int unreadMessagesCount;
  ChatContactModel({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.token,
    required this.timeSent,
    required this.lastMessage,
    required this.unreadMessagesCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'token': token,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'unreadMessagesCount': unreadMessagesCount,
    };
  }

  factory ChatContactModel.fromMap(Map<String, dynamic> map) {
    return ChatContactModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      token: map['token'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
      unreadMessagesCount: map['unreadMessagesCount'] as int,
    );
  }
}
