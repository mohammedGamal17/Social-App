import 'package:social/models/notification_model/Data.dart';
import 'package:social/models/notification_model/Notification.dart';

class NotificationsModel {
  Data? data;
  Notification? notification;
  String priority;
  String to;

  NotificationsModel({
    required this.data,
    required this.notification,
    required this.priority,
    required this.to,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      notification: json['notification'] != null
          ? Notification.fromJson(json['notification'])
          : null,
      priority: json['priority'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priority'] = priority;
    data['to'] = to;
    data['data'] = this.data?.toJson();
    data['notification'] = notification?.toJson();
    return data;
  }
}
