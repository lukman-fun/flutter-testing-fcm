// To parse this JSON data, do
//
//     final examModel = examModelFromJson(jsondynamic);

import 'dart:convert';

ExamModel examModelFromJson(dynamic str) => ExamModel.fromJson(json.decode(str));

dynamic examModelToJson(ExamModel data) => json.encode(data.toJson());

class ExamModel {
  dynamic status;
  List<Datum> data;

  ExamModel({
    required this.status,
    required this.data,
  });

  factory ExamModel.fromJson(Map<dynamic, dynamic> json) => ExamModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  DateTime date;
  dynamic startTime;
  dynamic endTime;
  List<Schedule> schedule;

  Datum({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.schedule,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        schedule: List<Schedule>.from(
            json["schedule"].map((x) => Schedule.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      };
}

class Schedule {
  dynamic id;
  dynamic classId;
  dynamic semesterId;
  dynamic courseId;
  dynamic studyYearId;
  DateTime examDate;
  dynamic startTime;
  dynamic endTime;
  DateTime createdAt;
  DateTime updatedAt;
  Course course;

  Schedule({
    required this.id,
    required this.classId,
    required this.semesterId,
    required this.courseId,
    required this.studyYearId,
    required this.examDate,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.course,
  });

  factory Schedule.fromJson(Map<dynamic, dynamic> json) => Schedule(
        id: json["id"],
        classId: json["class_id"],
        semesterId: json["semester_id"],
        courseId: json["course_id"],
        studyYearId: json["study_year_id"],
        examDate: DateTime.parse(json["exam_date"]),
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
        "exam_date":
            "${examDate.year.toString().padLeft(4, '0')}-${examDate.month.toString().padLeft(2, '0')}-${examDate.day.toString().padLeft(2, '0')}",
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
