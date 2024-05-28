// To parse this JSON data, do
//
//     final successModel = successModelFromJson(jsondynamic);

import 'dart:convert';

SuccessModel successModelFromJson(dynamic str) => SuccessModel.fromJson(json.decode(str));

dynamic successModelToJson(SuccessModel data) => json.encode(data.toJson());

class SuccessModel {
    dynamic status;
    dynamic message;

    SuccessModel({
        required this.status,
        required this.message,
    });

    factory SuccessModel.fromJson(Map<dynamic, dynamic> json) => SuccessModel(
        status: json["status"],
        message: json["message"],
    );

    Map<dynamic, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
