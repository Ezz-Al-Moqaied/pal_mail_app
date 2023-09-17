import 'dart:convert';

TagsModel tagsModelFromJson(String str) => TagsModel.fromJson(json.decode(str));

String tagsModelToJson(TagsModel data) => json.encode(data.toJson());

class TagsModel {
  List<Tag>? tags;

  TagsModel({
    this.tags,
  });

  factory TagsModel.fromJson(Map<String, dynamic> json) => TagsModel(
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class Tag {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Tag({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
