// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsondynamic);

import 'dart:convert';

DistrictModel districtModelFromJson(dynamic str) => DistrictModel.fromJson(json.decode(str));

dynamic districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
    dynamic status;
    List<Datum> data;

    DistrictModel({
        required this.status,
        required this.data,
    });

    factory DistrictModel.fromJson(Map<dynamic, dynamic> json) => DistrictModel(
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
    dynamic regencyId;
    dynamic name;

    Datum({
        required this.id,
        required this.regencyId,
        required this.name,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
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
