// To parse this JSON data, do
//
//     final cats = catsFromJson(jsonString);

import 'dart:convert';

Cats catsFromJson(String str) => Cats.fromJson(json.decode(str));

String catsToJson(Cats data) => json.encode(data.toJson());

class Cats {
  Cats({
    this.id,
    this.createdAt,
    this.tags,
    this.url,
  });

  String id;
  DateTime createdAt;
  List<String> tags;
  String url;

  factory Cats.fromJson(Map<String, dynamic> json) => Cats(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "url": url == null ? null : url,
      };
}
