import 'dart:convert';

import 'package:englens/src/core/configs/hive/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'generated/schedule_notification.g.dart';

@HiveType(typeId: HiveTypes.scheduledNotification)
class ScheduleNotification {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  @HiveField(3)
  String scheduleDate;

  ScheduleNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduleDate,
  });

  factory ScheduleNotification.fromJson(Map<String, dynamic> json) {
    return ScheduleNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      scheduleDate: json['scheduleDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'scheduleDate': scheduleDate,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
