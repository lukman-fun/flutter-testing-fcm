// To parse this JSON data, do
//
//     final semesterModel = semesterModelFromJson(jsondynamic);

import 'dart:convert';

SemesterModel semesterModelFromJson(dynamic str) =>
    SemesterModel.fromJson(json.decode(str));

dynamic semesterModelToJson(SemesterModel data) => json.encode(data.toJson());

class SemesterModel {
  dynamic status;
  CurrentSemester currentSemester;
  List<CurrentSemester> data;

  SemesterModel({
    required this.status,
    required this.currentSemester,
    required this.data,
  });

  factory SemesterModel.fromJson(Map<dynamic, dynamic> json) => SemesterModel(
        status: json["status"],
        currentSemester: CurrentSemester.fromJson(json["current_semester"]),
        data: List<CurrentSemester>.from(
            json["data"].map((x) => CurrentSemester.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "current_semester": currentSemester.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CurrentSemester {
  dynamic id;
  dynamic code;
  dynamic name;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  CurrentSemester({
    required this.id,
    required this.code,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentSemester.fromJson(Map<dynamic, dynamic> json) =>
      CurrentSemester(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
