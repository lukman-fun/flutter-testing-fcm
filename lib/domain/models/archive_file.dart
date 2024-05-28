// To parse this JSON data, do
//
//     final archiveFileModel = archiveFileModelFromJson(jsondynamic);

import 'dart:convert';

ArchiveFileModel archiveFileModelFromJson(dynamic str) => ArchiveFileModel.fromJson(json.decode(str));

dynamic archiveFileModelToJson(ArchiveFileModel data) => json.encode(data.toJson());

class ArchiveFileModel {
    dynamic status;
    List<Datum> data;

    ArchiveFileModel({
        required this.status,
        required this.data,
    });

    factory ArchiveFileModel.fromJson(Map<dynamic, dynamic> json) => ArchiveFileModel(
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
    dynamic title;
    dynamic file;
    dynamic status;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.title,
        required this.file,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        file: json["file"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file": file,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
