// To parse this JSON data, do
//
//     final allStudentClassesModel = allStudentClassesModelFromJson(jsondynamic);

import 'dart:convert';

AllStudentClassesModel allStudentClassesModelFromJson(dynamic str) => AllStudentClassesModel.fromJson(json.decode(str));

dynamic allStudentClassesModelToJson(AllStudentClassesModel data) => json.encode(data.toJson());

class AllStudentClassesModel {
    dynamic status;
    List<Datum> data;

    AllStudentClassesModel({
        required this.status,
        required this.data,
    });

    factory AllStudentClassesModel.fromJson(Map<dynamic, dynamic> json) => AllStudentClassesModel(
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
    dynamic classId;
    dynamic userId;
    dynamic studyYearId;
    DateTime createdAt;
    DateTime updatedAt;
    Student student;

    Datum({
        required this.id,
        required this.classId,
        required this.userId,
        required this.studyYearId,
        required this.createdAt,
        required this.updatedAt,
        required this.student,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        classId: json["class_id"],
        userId: json["user_id"],
        studyYearId: json["study_year_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        student: Student.fromJson(json["student"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "user_id": userId,
        "study_year_id": studyYearId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "student": student.toJson(),
    };
}

class Student {
    dynamic id;
    dynamic name;
    dynamic username;
    dynamic email;
    dynamic emailVerifiedAt;
    dynamic image;
    dynamic role;
    DateTime createdAt;
    DateTime updatedAt;

    Student({
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

    factory Student.fromJson(Map<dynamic, dynamic> json) => Student(
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
