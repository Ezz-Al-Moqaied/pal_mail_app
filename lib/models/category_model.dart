import 'dart:convert';

<<<<<<< HEAD
CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
=======
CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));
>>>>>>> origin/master

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category>? categories;

  CategoryModel({
    this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
<<<<<<< HEAD
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
=======
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
>>>>>>> origin/master
}

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? sendersCount;
  List<Sender>? senders;

  Category({
<<<<<<< HEAD
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.sendersCount,
    this.senders,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    sendersCount: json["senders_count"],
    senders: json["senders"] == null ? [] : List<Sender>.from(json["senders"]!.map((x) => Sender.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "senders_count": sendersCount,
    "senders": senders == null ? [] : List<dynamic>.from(senders!.map((x) => x.toJson())),
  };
=======
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.sendersCount,
    required this.senders,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sendersCount: json["senders_count"],
        senders: json["senders"] == null
            ? []
            : List<Sender>.from(
                json["senders"]!.map((x) => Sender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "senders_count": sendersCount,
        "senders": senders == null
            ? []
            : List<dynamic>.from(senders!.map((x) => x.toJson())),
      };
>>>>>>> origin/master
}

class Sender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
<<<<<<< HEAD
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    categoryId: json["category_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "address": address,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
=======
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
>>>>>>> origin/master
}
