class MessageModel {
  late String messageText;
  late String senderId;
  late String receiverId;
  late String messageTime;
  late String date;
  String? image;
  String? video;
  String? record;

  MessageModel({
    required this.messageText,
    required this.senderId,
    required this.receiverId,
    required this.messageTime,
    required this.date,
    this.image,
    this.video,
    this.record,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageText: json['messageText'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      messageTime: json['messageTime'],
      image: json['image'],
      date: json['date'],
      video: json['video'],
      record: json['record'],
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
    data['video'] = video;
    data['record'] = record;
    return data;
  }
}
