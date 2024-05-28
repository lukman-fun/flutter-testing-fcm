// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsondynamic);

import 'dart:convert';

LoginModel loginModelFromJson(dynamic str) =>
    LoginModel.fromJson(json.decode(str));

dynamic loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  dynamic status;
  TranscriptValue transcriptValue;
  User user;
  Authorization authorization;

  LoginModel({
    required this.status,
    required this.transcriptValue,
    required this.user,
    required this.authorization,
  });

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
        status: json["status"],
        transcriptValue: TranscriptValue.fromJson(json["transcript_value"]),
        user: User.fromJson(json["user"]),
        authorization: Authorization.fromJson(json["authorization"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "transcript_value": transcriptValue.toJson(),
        "user": user.toJson(),
        "authorization": authorization.toJson(),
      };
}

class Authorization {
  dynamic token;
  dynamic type;

  Authorization({
    required this.token,
    required this.type,
  });

  factory Authorization.fromJson(Map<dynamic, dynamic> json) => Authorization(
        token: json["token"],
        type: json["type"],
      );

  Map<dynamic, dynamic> toJson() => {
        "token": token,
        "type": type,
      };
}

class TranscriptValue {
  int totalAllCourseValue;
  int countAllCourse;
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

class User {
  int id;
  dynamic name;
  dynamic username;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic? image;
  dynamic role;
  DateTime createdAt;
  DateTime updatedAt;
  StudentBiodata? studentBiodata;
  TeacherBiodata? teacherBiodata;
  ParentBiodata? parentBiodata;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    this.image,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.studentBiodata,
    this.teacherBiodata,
    this.parentBiodata,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        image: json["image"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // studentBiodata: json["student_biodata"] != null ? StudentBiodata.fromJson(json["student_biodata"]) : null,
        // teacherBiodata: json["teacher_biodata"] != null ? TeacherBiodata.fromJson(json["teacher_biodata"]) : null,
        // parentBiodata: json["parent_biodata"] != null ? ParentBiodata.fromJson(json["parent_biodata"]) : null,
        studentBiodata: json["student_biodata"] != null
            ? StudentBiodata.fromJson(json["student_biodata"])
            : null,
        teacherBiodata: json["teacher_biodata"] != null
            ? TeacherBiodata.fromJson(json["teacher_biodata"])
            : null,
        parentBiodata: json["parent_biodata"] != null
            ? ParentBiodata.fromJson(json["parent_biodata"])
            : null,
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
        "student_biodata": studentBiodata?.toJson(),
        "teacher_biodata": teacherBiodata?.toJson(),
        "parent_biodata": parentBiodata?.toJson(),
      };
}

class ParentBiodata {
  int id;
  dynamic userId;
  dynamic nik;
  dynamic birthPlace;
  dynamic birthDate;
  dynamic? provinceId;
  dynamic? regencyId;
  dynamic? districtId;
  dynamic? villageId;
  dynamic address;
  dynamic studentName;
  dynamic studentBirthPlace;
  dynamic studentBirthDate;
  dynamic identityImage;
  DateTime createdAt;
  DateTime updatedAt;
  Province? province;
  Regency? regency;
  District? district;
  Village? village;

  ParentBiodata({
    required this.id,
    required this.userId,
    required this.nik,
    required this.birthPlace,
    required this.birthDate,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    required this.address,
    required this.studentName,
    required this.studentBirthPlace,
    required this.studentBirthDate,
    required this.identityImage,
    required this.createdAt,
    required this.updatedAt,
    this.province,
    this.regency,
    this.district,
    this.village,
  });

  factory ParentBiodata.fromJson(Map<dynamic, dynamic> json) => ParentBiodata(
        id: json["id"],
        userId: json["user_id"],
        nik: json["nik"],
        birthPlace: json["birth_place"],
        birthDate: json["birth_date"],
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        districtId: json["district_id"],
        villageId: json["village_id"],
        address: json["address"],
        studentName: json["student_name"],
        studentBirthPlace: json["student_birth_place"],
        studentBirthDate: json["student_birth_date"],
        identityImage: json["identity_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        province: json["province"] != null
            ? Province.fromJson(json["province"])
            : null,
        regency:
            json["regency"] != null ? Regency.fromJson(json["regency"]) : null,
        district: json["district"] != null
            ? District.fromJson(json["district"])
            : null,
        village:
            json["village"] != null ? Village.fromJson(json["village"]) : null,
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nik": nik,
        "birth_place": birthPlace,
        "birth_date": birthDate,
        "province_id": provinceId,
        "regency_id": regencyId,
        "district_id": districtId,
        "village_id": villageId,
        "address": address,
        "student_name": studentName,
        "student_birth_place": studentBirthPlace,
        "student_birth_date": studentBirthDate,
        "identity_image": identityImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "province": province?.toJson(),
        "regency": regency?.toJson(),
        "district": district?.toJson(),
        "village": village?.toJson(),
      };
}

class StudentBiodata {
  int id;
  dynamic userId;
  dynamic? nisn;
  dynamic? birthPlace;
  DateTime? birthDate;
  dynamic? provinceId;
  dynamic? regencyId;
  dynamic? districtId;
  dynamic? villageId;
  dynamic? address;
  dynamic? parentName;
  dynamic? parentJob;
  dynamic? parentPhone;
  dynamic? parentAddress;
  DateTime createdAt;
  DateTime updatedAt;
  Province? province;
  Regency? regency;
  District? district;
  Village? village;

  StudentBiodata({
    required this.id,
    required this.userId,
    this.nisn,
    this.birthPlace,
    this.birthDate,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.address,
    this.parentName,
    this.parentJob,
    this.parentPhone,
    this.parentAddress,
    required this.createdAt,
    required this.updatedAt,
    this.province,
    this.regency,
    this.district,
    this.village,
  });

  factory StudentBiodata.fromJson(Map<dynamic, dynamic> json) => StudentBiodata(
        id: json["id"],
        userId: json["user_id"],
        nisn: json["nisn"],
        birthPlace: json["birth_place"],
        birthDate: DateTime.parse(json["birth_date"]),
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        districtId: json["district_id"],
        villageId: json["village_id"],
        address: json["address"],
        parentName: json["parent_name"],
        parentJob: json["parent_job"],
        parentPhone: json["parent_phone"],
        parentAddress: json["parent_address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        province: json["province"] != null
            ? Province.fromJson(json["province"])
            : null,
        regency:
            json["regency"] != null ? Regency.fromJson(json["regency"]) : null,
        district: json["district"] != null
            ? District.fromJson(json["district"])
            : null,
        village:
            json["village"] != null ? Village.fromJson(json["village"]) : null,
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nisn": nisn,
        "birth_place": birthPlace,
        "birth_date":
            "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
        "province_id": provinceId,
        "regency_id": regencyId,
        "district_id": districtId,
        "village_id": villageId,
        "address": address,
        "parent_name": parentName,
        "parent_job": parentJob,
        "parent_phone": parentPhone,
        "parent_address": parentAddress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "province": province?.toJson(),
        "regency": regency?.toJson(),
        "district": district?.toJson(),
        "village": village?.toJson(),
      };
}

class TeacherBiodata {
  int id;
  dynamic userId;
  dynamic nik;
  dynamic birthPlace;
  dynamic birthDate;
  dynamic? provinceId;
  dynamic? regencyId;
  dynamic? districtId;
  dynamic? villageId;
  dynamic address;
  DateTime createdAt;
  DateTime updatedAt;
  Province? province;
  Regency? regency;
  District? district;
  Village? village;

  TeacherBiodata({
    required this.id,
    required this.userId,
    required this.nik,
    required this.birthPlace,
    required this.birthDate,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    this.province,
    this.regency,
    this.district,
    this.village,
  });

  factory TeacherBiodata.fromJson(Map<dynamic, dynamic> json) => TeacherBiodata(
        id: json["id"],
        userId: json["user_id"],
        nik: json["nik"],
        birthPlace: json["birth_place"],
        birthDate: json["birth_date"],
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        districtId: json["district_id"],
        villageId: json["village_id"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        province: json["province"] != null
            ? Province.fromJson(json["province"])
            : null,
        regency:
            json["regency"] != null ? Regency.fromJson(json["regency"]) : null,
        district: json["district"] != null
            ? District.fromJson(json["district"])
            : null,
        village:
            json["village"] != null ? Village.fromJson(json["village"]) : null,
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nik": nik,
        "birth_place": birthPlace,
        "birth_date": birthDate,
        "province_id": provinceId,
        "regency_id": regencyId,
        "district_id": districtId,
        "village_id": villageId,
        "address": address,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "province": province?.toJson(),
        "regency": regency?.toJson(),
        "district": district?.toJson(),
        "village": village?.toJson(),
      };
}

class District {
  int id;
  dynamic regencyId;
  dynamic name;

  District({
    required this.id,
    required this.regencyId,
    required this.name,
  });

  factory District.fromJson(Map<dynamic, dynamic> json) => District(
        id: json["id"],
        regencyId: json["regency_id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
      };
}

class Province {
  int id;
  dynamic name;

  Province({
    required this.id,
    required this.name,
  });

  factory Province.fromJson(Map<dynamic, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Regency {
  int id;
  dynamic provinceId;
  dynamic name;

  Regency({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  factory Regency.fromJson(Map<dynamic, dynamic> json) => Regency(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}

class Village {
  int id;
  dynamic districtId;
  dynamic name;

  Village({
    required this.id,
    required this.districtId,
    required this.name,
  });

  factory Village.fromJson(Map<dynamic, dynamic> json) => Village(
        id: json["id"],
        districtId: json["district_id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "district_id": districtId,
        "name": name,
      };
}
