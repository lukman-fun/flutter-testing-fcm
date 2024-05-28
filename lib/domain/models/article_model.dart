// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsondynamic);

import 'dart:convert';

ArticleModel articleModelFromJson(dynamic str) =>
    ArticleModel.fromJson(json.decode(str));

dynamic articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  dynamic status;
  List<Datum> data;

  ArticleModel({
    required this.status,
    required this.data,
  });

  factory ArticleModel.fromJson(Map<dynamic, dynamic> json) => ArticleModel(
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
  dynamic slug;
  dynamic thumbnail;
  dynamic content;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnail,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        thumbnail: json["thumbnail"],
        content: json["content"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "thumbnail": thumbnail,
        "content": content,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
