class Data {
  String clickAction;
  String id;
  String status;

  Data({
    required this.clickAction,
    required this.id,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      clickAction: json['click_action'],
      id: json['id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['click_action'] = clickAction;
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}
