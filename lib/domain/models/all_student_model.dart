// To parse this JSON data, do
//
//     final allStudentModel = allStudentModelFromJson(jsondynamic);

import 'dart:convert';

AllStudentModel allStudentModelFromJson(dynamic str) => AllStudentModel.fromJson(json.decode(str));

dynamic allStudentModelToJson(AllStudentModel data) => json.encode(data.toJson());

class AllStudentModel {
    dynamic status;
    List<Datum> data;

    AllStudentModel({
        required this.status,
        required this.data,
    });

    factory AllStudentModel.fromJson(Map<dynamic, dynamic> json) => AllStudentModel(
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
    dynamic name;
    dynamic username;
    dynamic email;
    dynamic emailVerifiedAt;
    dynamic image;
    dynamic role;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.emailVerifiedAt,
        required this.image,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        image: json["image"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "image": image,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
