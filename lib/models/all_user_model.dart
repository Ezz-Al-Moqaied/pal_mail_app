import 'dart:convert';

import 'package:pal_mail_app/models/user_model.dart';

AllUserModel allUserModelFromJson(String str) =>
    AllUserModel.fromJson(json.decode(str));

String allUserModelToJson(AllUserModel data) => json.encode(data.toJson());

class AllUserModel {
  List<User>? users;

  AllUserModel({
    this.users,
  });

  factory AllUserModel.fromJson(Map<String, dynamic> json) => AllUserModel(
    users: json["users"] == null
        ? []
        : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": users == null
        ? []
        : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  dynamic emailVerifiedAt;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  Roles? role;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    roleId: json["role_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    role: json["role"] == null ? null : Roles.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "role_id": roleId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "role": role?.toJson(),
  };
}

class Roles extends Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Roles({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  }) : super(id: 0, name: '', createdAt: '', updatedAt: '');

  factory Roles.fromJson(Map<String, dynamic> json) => Roles(
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