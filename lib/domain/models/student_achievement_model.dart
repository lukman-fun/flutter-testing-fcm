// To parse this JSON data, do
//
//     final studentAchievementModel = studentAchievementModelFromJson(jsondynamic);

import 'dart:convert';

StudentAchievementModel studentAchievementModelFromJson(dynamic str) =>
    StudentAchievementModel.fromJson(json.decode(str));

dynamic studentAchievementModelToJson(StudentAchievementModel data) =>
    json.encode(data.toJson());

class StudentAchievementModel {
  dynamic status;
  List<Datum> data;

  StudentAchievementModel({
    required this.status,
    required this.data,
  });

  factory StudentAchievementModel.fromJson(Map<dynamic, dynamic> json) =>
      StudentAchievementModel(
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
  dynamic userId;
  dynamic title;
  DateTime achievementDate;
  dynamic type;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.title,
    required this.achievementDate,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        achievementDate: DateTime.parse(json["achievement_date"]),
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "achievement_date":
            "${achievementDate.year.toString().padLeft(4, '0')}-${achievementDate.month.toString().padLeft(2, '0')}-${achievementDate.day.toString().padLeft(2, '0')}",
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
