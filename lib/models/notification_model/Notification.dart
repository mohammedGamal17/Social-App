class Notification {
  String body;
  String color;
  String title;

  Notification({
    required this.body,
    required this.color,
    required this.title,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      body: json['body'],
      color: json['color'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['color'] = color;
    data['title'] = title;
    return data;
  }
}
