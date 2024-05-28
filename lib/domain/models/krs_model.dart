// To parse this JSON data, do
//
//     final krsModel = krsModelFromJson(jsondynamic);

import 'dart:convert';

KrsModel krsModelFromJson(dynamic str) => KrsModel.fromJson(json.decode(str));

dynamic krsModelToJson(KrsModel data) => json.encode(data.toJson());

class KrsModel {
  dynamic status;
  Classes semester;
  StudyYear studyYear;
  Classes classes;
  List<Datum> data;

  KrsModel({
    required this.status,
    required this.semester,
    required this.studyYear,
    required this.classes,
    required this.data,
  });

  factory KrsModel.fromJson(Map<dynamic, dynamic> json) => KrsModel(
        status: json["status"],
        semester: Classes.fromJson(json["semester"]),
        studyYear: StudyYear.fromJson(json["study_year"]),
        classes: Classes.fromJson(json["classes"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "semester": semester.toJson(),
        "study_year": studyYear.toJson(),
        "classes": classes.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Classes {
  dynamic id;
  dynamic code;
  dynamic name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic? valueable;
  dynamic? status;

  Classes({
    required this.id,
    required this.code,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.valueable,
    this.status,
  });

  factory Classes.fromJson(Map<dynamic, dynamic> json) => Classes(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        valueable: json["valueable"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "valueable": valueable,
        "status": status,
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
  Classes course;

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
        course: Classes.fromJson(json["course"]),
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

class StudyYear {
  dynamic id;
  dynamic startYear;
  dynamic endYear;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  StudyYear({
    required this.id,
    required this.startYear,
    required this.endYear,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyYear.fromJson(Map<dynamic, dynamic> json) => StudyYear(
        id: json["id"],
        startYear: json["start_year"],
        endYear: json["end_year"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "start_year": startYear,
        "end_year": endYear,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
