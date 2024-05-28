// To parse this JSON data, do
//
//     final classesModel = classesModelFromJson(jsondynamic);

import 'dart:convert';

ClassesModel classesModelFromJson(dynamic str) => ClassesModel.fromJson(json.decode(str));

dynamic classesModelToJson(ClassesModel data) => json.encode(data.toJson());

class ClassesModel {
    dynamic status;
    CurrentClass currentClass;
    List<CurrentClass> data;

    ClassesModel({
        required this.status,
        required this.currentClass,
        required this.data,
    });

    factory ClassesModel.fromJson(Map<dynamic, dynamic> json) => ClassesModel(
        status: json["status"],
        currentClass: CurrentClass.fromJson(json["current_class"]),
        data: List<CurrentClass>.from(json["data"].map((x) => CurrentClass.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "status": status,
        "current_class": currentClass.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CurrentClass {
    dynamic id;
    dynamic code;
    dynamic name;
    DateTime createdAt;
    DateTime updatedAt;

    CurrentClass({
        required this.id,
        required this.code,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CurrentClass.fromJson(Map<dynamic, dynamic> json) => CurrentClass(
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
