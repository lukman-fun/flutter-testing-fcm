// To parse this JSON data, do
//
//     final studentReportModel = studentReportModelFromJson(jsondynamic);

import 'dart:convert';

StudentReportModel studentReportModelFromJson(dynamic str) =>
    StudentReportModel.fromJson(json.decode(str));

dynamic studentReportModelToJson(StudentReportModel data) =>
    json.encode(data.toJson());

class StudentReportModel {
  dynamic status;
  List<Datum> data;

  StudentReportModel({
    required this.status,
    required this.data,
  });

  factory StudentReportModel.fromJson(Map<String, dynamic> json) =>
      StudentReportModel(
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
  dynamic semesterId;
  dynamic studyYearId;
  dynamic urlDownload;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic urlDownloadConvert;
  StudyYear studyYear;
  Classes classes;
  Classes semester;

  Datum({
    required this.id,
    required this.userId,
    required this.classId,
    required this.semesterId,
    required this.studyYearId,
    required this.urlDownload,
    required this.createdAt,
    required this.updatedAt,
    required this.urlDownloadConvert,
    required this.studyYear,
    required this.classes,
    required this.semester,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        classId: json["class_id"],
        semesterId: json["semester_id"],
        studyYearId: json["study_year_id"],
        urlDownload: json["url_download"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        urlDownloadConvert: json["url_download_convert"],
        studyYear: StudyYear.fromJson(json["study_year"]),
        classes: Classes.fromJson(json["classes"]),
        semester: Classes.fromJson(json["semester"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_id": classId,
        "semester_id": semesterId,
        "study_year_id": studyYearId,
        "url_download": urlDownload,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url_download_convert": urlDownloadConvert,
        "study_year": studyYear.toJson(),
        "classes": classes.toJson(),
        "semester": semester.toJson(),
      };
}

class Classes {
  dynamic id;
  dynamic code;
  dynamic name;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic? status;

  Classes({
    required this.id,
    required this.code,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.status,
  });

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
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

  factory StudyYear.fromJson(Map<String, dynamic> json) => StudyYear(
        id: json["id"],
        startYear: json["start_year"],
        endYear: json["end_year"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_year": startYear,
        "end_year": endYear,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
