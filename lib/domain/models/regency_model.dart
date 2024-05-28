// To parse this JSON data, do
//
//     final regencyModel = regencyModelFromJson(jsondynamic);

import 'dart:convert';

RegencyModel regencyModelFromJson(dynamic str) => RegencyModel.fromJson(json.decode(str));

dynamic regencyModelToJson(RegencyModel data) => json.encode(data.toJson());

class RegencyModel {
    dynamic status;
    List<Datum> data;

    RegencyModel({
        required this.status,
        required this.data,
    });

    factory RegencyModel.fromJson(Map<dynamic, dynamic> json) => RegencyModel(
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
    dynamic provinceId;
    dynamic name;

    Datum({
        required this.id,
        required this.provinceId,
        required this.name,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
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
