class MessageModel {
  late String messageText;
  late String senderId;
  late String receiverId;
  late String messageTime;

  MessageModel({
    required this.messageText,
    required this.senderId,
    required this.receiverId,
    required this.messageTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageText: json['messageText'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      messageTime: json['messageTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageText'] = messageText;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['messageTime'] = messageTime;
    return data;
  }
}
