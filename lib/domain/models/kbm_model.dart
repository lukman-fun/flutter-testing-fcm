// To parse this JSON data, do
//
//     final kbmModel = kbmModelFromJson(jsondynamic);

import 'dart:convert';

KbmModel kbmModelFromJson(dynamic str) => KbmModel.fromJson(json.decode(str));

dynamic kbmModelToJson(KbmModel data) => json.encode(data.toJson());

class KbmModel {
  dynamic status;
  List<Datum> data;

  KbmModel({
    required this.status,
    required this.data,
  });

  factory KbmModel.fromJson(Map<dynamic, dynamic> json) => KbmModel(
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
  dynamic classId;
  dynamic semesterId;
  dynamic courseId;
  dynamic studyYearId;
  dynamic day;
  dynamic startTime;
  dynamic endTime;
  DateTime createdAt;
  DateTime updatedAt;
  Course course;

  Datum({
    required this.id,
    required this.classId,
    required this.semesterId,
    required this.courseId,
    required this.studyYearId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.course,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        classId: json["class_id"],
        semesterId: json["semester_id"],
        courseId: json["course_id"],
        studyYearId: json["study_year_id"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        course: Course.fromJson(json["course"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "semester_id": semesterId,
        "course_id": courseId,
        "study_year_id": studyYearId,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "course": course.toJson(),
      };
}

class Course {
  dynamic id;
  dynamic code;
  dynamic name;
  DateTime createdAt;
  DateTime updatedAt;

  Course({
    required this.id,
    required this.code,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<dynamic, dynamic> json) => Course(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
