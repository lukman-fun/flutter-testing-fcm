// To parse this JSON data, do
//
//     final teacherClassesModel = teacherClassesModelFromJson(jsondynamic);

import 'dart:convert';

TeacherClassesModel teacherClassesModelFromJson(dynamic str) => TeacherClassesModel.fromJson(json.decode(str));

dynamic teacherClassesModelToJson(TeacherClassesModel data) => json.encode(data.toJson());

class TeacherClassesModel {
    dynamic status;
    List<Datum> data;

    TeacherClassesModel({
        required this.status,
        required this.data,
    });

    factory TeacherClassesModel.fromJson(Map<dynamic, dynamic> json) => TeacherClassesModel(
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
    dynamic code;
    dynamic name;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.code,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
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
