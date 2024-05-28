// To parse this JSON data, do
//
//     final studyYearModel = studyYearModelFromJson(jsondynamic);

import 'dart:convert';

StudyYearModel studyYearModelFromJson(dynamic str) =>
    StudyYearModel.fromJson(json.decode(str));

dynamic studyYearModelToJson(StudyYearModel data) => json.encode(data.toJson());

class StudyYearModel {
  dynamic status;
  CurrentStudyYear currentStudyYear;
  List<CurrentStudyYear> data;

  StudyYearModel({
    required this.status,
    required this.currentStudyYear,
    required this.data,
  });

  factory StudyYearModel.fromJson(Map<dynamic, dynamic> json) => StudyYearModel(
        status: json["status"],
        currentStudyYear: CurrentStudyYear.fromJson(json["current_study_year"]),
        data: List<CurrentStudyYear>.from(
            json["data"].map((x) => CurrentStudyYear.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "current_study_year": currentStudyYear.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CurrentStudyYear {
  dynamic id;
  dynamic startYear;
  dynamic endYear;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  CurrentStudyYear({
    required this.id,
    required this.startYear,
    required this.endYear,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentStudyYear.fromJson(Map<dynamic, dynamic> json) =>
      CurrentStudyYear(
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
