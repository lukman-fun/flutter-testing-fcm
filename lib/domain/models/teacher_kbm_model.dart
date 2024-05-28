// To parse this JSON data, do
//
//     final teacherKbmModel = teacherKbmModelFromJson(jsondynamic);

import 'dart:convert';

TeacherKbmModel teacherKbmModelFromJson(dynamic str) => TeacherKbmModel.fromJson(json.decode(str));

dynamic teacherKbmModelToJson(TeacherKbmModel data) => json.encode(data.toJson());

class TeacherKbmModel {
    dynamic status;
    List<TeacherKbmModelDatum> data;

    TeacherKbmModel({
        required this.status,
        required this.data,
    });

    factory TeacherKbmModel.fromJson(Map<dynamic, dynamic> json) => TeacherKbmModel(
        status: json["status"],
        data: List<TeacherKbmModelDatum>.from(json["data"].map((x) => TeacherKbmModelDatum.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class TeacherKbmModelDatum {
    Classes classes;
    List<DatumDatum> data;

    TeacherKbmModelDatum({
        required this.classes,
        required this.data,
    });

    factory TeacherKbmModelDatum.fromJson(Map<dynamic, dynamic> json) => TeacherKbmModelDatum(
        classes: Classes.fromJson(json["classes"]),
        data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "classes": classes.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Classes {
    dynamic id;
    dynamic code;
    dynamic name;
    DateTime createdAt;
    DateTime updatedAt;
    CourseTeacher? courseTeacher;

    Classes({
        required this.id,
        required this.code,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        this.courseTeacher,
    });

    factory Classes.fromJson(Map<dynamic, dynamic> json) => Classes(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        courseTeacher: json["course_teacher"] == null ? null : CourseTeacher.fromJson(json["course_teacher"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "course_teacher": courseTeacher?.toJson(),
    };
}

class CourseTeacher {
    dynamic id;
    dynamic courseId;
    dynamic teacherId;
    dynamic studyYearId;
    DateTime createdAt;
    DateTime updatedAt;
    Teacher teacher;

    CourseTeacher({
        required this.id,
        required this.courseId,
        required this.teacherId,
        required this.studyYearId,
        required this.createdAt,
        required this.updatedAt,
        required this.teacher,
    });

    factory CourseTeacher.fromJson(Map<dynamic, dynamic> json) => CourseTeacher(
        id: json["id"],
        courseId: json["course_id"],
        teacherId: json["teacher_id"],
        studyYearId: json["study_year_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        teacher: Teacher.fromJson(json["teacher"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "teacher_id": teacherId,
        "study_year_id": studyYearId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "teacher": teacher.toJson(),
    };
}

class Teacher {
    dynamic id;
    dynamic name;
    dynamic username;
    dynamic email;
    dynamic emailVerifiedAt;
    dynamic image;
    dynamic role;
    DateTime createdAt;
    DateTime updatedAt;

    Teacher({
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

    factory Teacher.fromJson(Map<dynamic, dynamic> json) => Teacher(
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

class DatumDatum {
    dynamic id;
    dynamic classId;
    dynamic semesterId;
    dynamic courseId;
    dynamic studyYearId;
    dynamic day;
    dynamic startTime;
    dynamic endTime;
    DateTime createdAt;
    DateTime updatedAt;
    Classes course;
    Classes classes;

    DatumDatum({
        required this.id,
        required this.classId,
        required this.semesterId,
        required this.courseId,
        required this.studyYearId,
        required this.day,
        required this.startTime,
        required this.endTime,
        required this.createdAt,
        required this.updatedAt,
        required this.course,
        required this.classes,
    });

    factory DatumDatum.fromJson(Map<dynamic, dynamic> json) => DatumDatum(
        id: json["id"],
        classId: json["class_id"],
        semesterId: json["semester_id"],
        courseId: json["course_id"],
        studyYearId: json["study_year_id"],
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        course: Classes.fromJson(json["course"]),
        classes: Classes.fromJson(json["classes"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "semester_id": semesterId,
        "course_id": courseId,
        "study_year_id": studyYearId,
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "course": course.toJson(),
        "classes": classes.toJson(),
    };
}
