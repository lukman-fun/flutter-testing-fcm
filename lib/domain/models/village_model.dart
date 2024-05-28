// To parse this JSON data, do
//
//     final villageModel = villageModelFromJson(jsondynamic);

import 'dart:convert';

VillageModel villageModelFromJson(dynamic str) =>
    VillageModel.fromJson(json.decode(str));

dynamic villageModelToJson(VillageModel data) => json.encode(data.toJson());

class VillageModel {
  dynamic status;
  List<Datum> data;

  VillageModel({
    required this.status,
    required this.data,
  });

  factory VillageModel.fromJson(Map<dynamic, dynamic> json) => VillageModel(
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
  dynamic districtId;
  dynamic name;

  Datum({
    required this.id,
    required this.districtId,
    required this.name,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
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
