// To parse this JSON data, do
//
//     final studentResultKbmModel = studentResultKbmModelFromJson(jsondynamic);

import 'dart:convert';

StudentResultKbmModel studentResultKbmModelFromJson(dynamic str) => StudentResultKbmModel.fromJson(json.decode(str));

dynamic studentResultKbmModelToJson(StudentResultKbmModel data) => json.encode(data.toJson());

class StudentResultKbmModel {
    dynamic status;
    List<Datum> data;

    StudentResultKbmModel({
        required this.status,
        required this.data,
    });

    factory StudentResultKbmModel.fromJson(Map<dynamic, dynamic> json) => StudentResultKbmModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "status": status,
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
