class MessageModel {
  late String messageText;
  late String senderId;
  late String receiverId;
  late String messageTime;
  late String date;
  String? image;

  MessageModel({
    required this.messageText,
    required this.senderId,
    required this.receiverId,
    required this.messageTime,
    required this.date,
    this.image,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageText: json['messageText'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      messageTime: json['messageTime'],
      image: json['image'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageText'] = messageText;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['messageTime'] = messageTime;
    data['image'] = image;
    data['date'] = date;
    return data;
  }
}
