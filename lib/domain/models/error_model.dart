// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsondynamic);

import 'dart:convert';

ErrorModel errorModelFromJson(dynamic str) =>
    ErrorModel.fromJson(json.decode(str));

dynamic errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  dynamic status;
  dynamic message;
  List<dynamic> validation;

  ErrorModel({
    required this.status,
    required this.message,
    required this.validation,
  });

  factory ErrorModel.fromJson(Map<dynamic, dynamic> json) => ErrorModel(
        status: json["status"],
        message: json["message"],
        validation: List<dynamic>.from(json["validation"].map((x) => x)),
      );

  Map<dynamic, dynamic> toJson() => {
        "status": status,
        "message": message,
        "validation": List<dynamic>.from(validation.map((x) => x)),
      };
}
