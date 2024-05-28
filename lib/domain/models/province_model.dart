// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsondynamic);

import 'dart:convert';

ProvinceModel provinceModelFromJson(dynamic str) => ProvinceModel.fromJson(json.decode(str));

dynamic provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
    dynamic status;
    List<Datum> data;

    ProvinceModel({
        required this.status,
        required this.data,
    });

    factory ProvinceModel.fromJson(Map<dynamic, dynamic> json) => ProvinceModel(
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

    Datum({
        required this.id,
        required this.name,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
