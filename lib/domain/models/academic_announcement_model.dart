// To parse this JSON data, do
//
//     final academicAnnouncementModel = academicAnnouncementModelFromJson(jsondynamic);

import 'dart:convert';

AcademicAnnouncementModel academicAnnouncementModelFromJson(dynamic str) =>
    AcademicAnnouncementModel.fromJson(json.decode(str));

dynamic academicAnnouncementModelToJson(AcademicAnnouncementModel data) =>
    json.encode(data.toJson());

class AcademicAnnouncementModel {
  dynamic status;
  Data data;

  AcademicAnnouncementModel({
    required this.status,
    required this.data,
  });

  factory AcademicAnnouncementModel.fromJson(Map<dynamic, dynamic> json) =>
      AcademicAnnouncementModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  dynamic id;
  dynamic code;
  dynamic title;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;
  List<ItemRegistrationSchedule> itemRegistrationSchedule;

  Data({
    required this.id,
    required this.code,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.itemRegistrationSchedule,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        id: json["id"],
        code: json["code"],
        title: json["title"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        itemRegistrationSchedule: List<ItemRegistrationSchedule>.from(
            json["item_registration_schedule"]
                .map((x) => ItemRegistrationSchedule.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "title": title,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "item_registration_schedule":
            List<dynamic>.from(itemRegistrationSchedule.map((x) => x.toJson())),
      };
}

class ItemRegistrationSchedule {
  dynamic id;
  dynamic registrationScheduleId;
  dynamic title;
  DateTime startDate;
  DateTime endDate;
  dynamic startTime;
  dynamic endTime;
  DateTime createdAt;
  DateTime updatedAt;

  ItemRegistrationSchedule({
    required this.id,
    required this.registrationScheduleId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemRegistrationSchedule.fromJson(Map<dynamic, dynamic> json) =>
      ItemRegistrationSchedule(
        id: json["id"],
        registrationScheduleId: json["registration_schedule_id"],
        title: json["title"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "registration_schedule_id": registrationScheduleId,
        "title": title,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
