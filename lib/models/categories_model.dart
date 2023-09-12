import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  List<CategoryElement> categories;

  CategoriesModel({
    required this.categories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    categories: List<CategoryElement>.from(json["categories"].map((x) => CategoryElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class CategoryElement {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String sendersCount;
  List<Sender> senders;

  CategoryElement({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.sendersCount,
    required this.senders,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    sendersCount: json["senders_count"],
    senders: List<Sender>.from(json["senders"].map((x) => Sender.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "senders_count": sendersCount,
    "senders": List<dynamic>.from(senders.map((x) => x.toJson())),
  };
}

class Sender {
  int id;
  String name;
  String mobile;
  String? address;
  String categoryId;
  String createdAt;
  String updatedAt;
  SenderCategory category;

  Sender({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    categoryId: json["category_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    category: SenderCategory.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "address": address,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category": category.toJson(),
  };
}

class SenderCategory {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  SenderCategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SenderCategory.fromJson(Map<String, dynamic> json) => SenderCategory(
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
