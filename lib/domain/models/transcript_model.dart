// To parse this JSON data, do
//
//     final transcriptModel = transcriptModelFromJson(jsondynamic);

import 'dart:convert';

TranscriptModel transcriptModelFromJson(dynamic str) =>
    TranscriptModel.fromJson(json.decode(str));

dynamic transcriptModelToJson(TranscriptModel data) =>
    json.encode(data.toJson());

class TranscriptModel {
  dynamic status;
  List<TranscriptModelDatum> data;

  TranscriptModel({
    required this.status,
    required this.data,
  });

  factory TranscriptModel.fromJson(Map<dynamic, dynamic> json) =>
      TranscriptModel(
        status: json["status"],
        data: List<TranscriptModelDatum>.from(
            json["data"].map((x) => TranscriptModelDatum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TranscriptModelDatum {
  dynamic code;
  Classes semester;
  Classes classes;
  StudyYear studyYear;
  List<DatumDatum> data;

  TranscriptModelDatum({
    required this.code,
    required this.semester,
    required this.classes,
    required this.studyYear,
    required this.data,
  });

  factory TranscriptModelDatum.fromJson(Map<dynamic, dynamic> json) =>
      TranscriptModelDatum(
        code: json["code"],
        semester: Classes.fromJson(json["semester"]),
        classes: Classes.fromJson(json["classes"]),
        studyYear: StudyYear.fromJson(json["study_year"]),
        data: List<DatumDatum>.from(
            json["data"].map((x) => DatumDatum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "code": code,
        "semester": semester.toJson(),
        "classes": classes.toJson(),
        "study_year": studyYear.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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

  factory Classes.fromJson(Map<dynamic, dynamic> json) => Classes(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
      };
}

class DatumDatum {
  dynamic id;
  dynamic classId;
  dynamic semesterId;
  dynamic courseId;
  dynamic userId;
  dynamic studyYearId;
  dynamic valueResult;
  DateTime createdAt;
  DateTime updatedAt;
  Classes classes;
  Classes semester;
  Classes course;
  StudyYear studyYear;

  DatumDatum({
    required this.id,
    required this.classId,
    required this.semesterId,
    required this.courseId,
    required this.userId,
    required this.studyYearId,
    required this.valueResult,
    required this.createdAt,
    required this.updatedAt,
    required this.classes,
    required this.semester,
    required this.course,
    required this.studyYear,
  });

  factory DatumDatum.fromJson(Map<dynamic, dynamic> json) => DatumDatum(
        id: json["id"],
        classId: json["class_id"],
        semesterId: json["semester_id"],
        courseId: json["course_id"],
        userId: json["user_id"],
        studyYearId: json["study_year_id"],
        valueResult: json["value_result"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        classes: Classes.fromJson(json["classes"]),
        semester: Classes.fromJson(json["semester"]),
        course: Classes.fromJson(json["course"]),
        studyYear: StudyYear.fromJson(json["study_year"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "semester_id": semesterId,
        "course_id": courseId,
        "user_id": userId,
        "study_year_id": studyYearId,
        "value_result": valueResult,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "classes": classes.toJson(),
        "semester": semester.toJson(),
        "course": course.toJson(),
        "study_year": studyYear.toJson(),
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
