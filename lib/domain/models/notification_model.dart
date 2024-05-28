// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsondynamic);

import 'dart:convert';

NotificationModel notificationModelFromJson(dynamic str) =>
    NotificationModel.fromJson(json.decode(str));

dynamic notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  dynamic status;
  List<Datum> data;

  NotificationModel({
    required this.status,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic title;
  dynamic subTitle;
  dynamic content;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        subTitle: json["sub_title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sub_title": subTitle,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
