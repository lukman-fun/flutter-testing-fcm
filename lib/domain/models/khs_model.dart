// To parse this JSON data, do
//
//     final khsModel = khsModelFromJson(jsondynamic);

import 'dart:convert';

KhsModel khsModelFromJson(dynamic str) => KhsModel.fromJson(json.decode(str));

dynamic khsModelToJson(KhsModel data) => json.encode(data.toJson());

class KhsModel {
  dynamic status;
  TranscriptValue transcriptValue;
  List<Datum> data;

  KhsModel({
    required this.status,
    required this.transcriptValue,
    required this.data,
  });

  factory KhsModel.fromJson(Map<dynamic, dynamic> json) => KhsModel(
        status: json["status"],
        transcriptValue: TranscriptValue.fromJson(json["transcript_value"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "transcript_value": transcriptValue.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic? studentResultId;
  dynamic? studentResultValue;
  Course course;

  Datum({
    required this.studentResultId,
    required this.studentResultValue,
    required this.course,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        studentResultId: json["studentResultId"],
        studentResultValue: json["studentResultValue"],
        course: Course.fromJson(json["course"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "studentResultId": studentResultId,
        "studentResultValue": studentResultValue,
        "course": course.toJson(),
      };
}

class Course {
  dynamic id;
  dynamic code;
  dynamic name;
  dynamic? valueable;
  DateTime createdAt;
  DateTime updatedAt;

  Course({
    required this.id,
    required this.code,
    required this.name,
    this.valueable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<dynamic, dynamic> json) => Course(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        valueable: json["valueable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "valueable": valueable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class TranscriptValue {
  dynamic totalAllCourseValue;
  dynamic countAllCourse;
  double valueAverage;

  TranscriptValue({
    required this.totalAllCourseValue,
    required this.countAllCourse,
    required this.valueAverage,
  });

  factory TranscriptValue.fromJson(Map<dynamic, dynamic> json) =>
      TranscriptValue(
        totalAllCourseValue: json["total_all_course_value"],
        countAllCourse: json["count_all_course"],
        valueAverage: json["value_average"]?.toDouble(),
      );

  Map<dynamic, dynamic> toJson() => {
        "total_all_course_value": totalAllCourseValue,
        "count_all_course": countAllCourse,
        "value_average": valueAverage,
      };
}
