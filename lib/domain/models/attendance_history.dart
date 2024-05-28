// To parse this JSON data, do
//
//     final attendanceHistoryModel = attendanceHistoryModelFromJson(jsondynamic);

import 'dart:convert';

AttendanceHistoryModel attendanceHistoryModelFromJson(dynamic str) =>
    AttendanceHistoryModel.fromJson(json.decode(str));

dynamic attendanceHistoryModelToJson(AttendanceHistoryModel data) =>
    json.encode(data.toJson());

class AttendanceHistoryModel {
  dynamic status;
  List<Datum> data;

  AttendanceHistoryModel({
    required this.status,
    required this.data,
  });

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic id;
  dynamic userId;
  dynamic classId;
  dynamic studyYearId;
  dynamic semesterId;
  dynamic startAttend;
  dynamic endAttend;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.classId,
    required this.studyYearId,
    required this.semesterId,
    required this.startAttend,
    required this.endAttend,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        classId: json["class_id"],
        studyYearId: json["study_year_id"],
        semesterId: json["semester_id"],
        startAttend: json["start_attend"],
        endAttend: json["end_attend"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_id": classId,
        "study_year_id": studyYearId,
        "semester_id": semesterId,
        "start_attend": startAttend,
        "end_attend": endAttend,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
