// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final UserClass user;
  final String token;

  UserModel({
    required this.user,
    required this.token,
  });

  UserModel copyWith({
    UserClass? user,
    String? token,
  }) =>
      UserModel(
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    user: UserClass.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class UserClass {
  final int? id;
  final String? name;
  final String? email;
  final String? image; // Updated to be nullable
  final String? emailVerifiedAt; // Updated to be nullable
  final String? roleId;
  final String? createdAt;
  final String? updatedAt;
  final Role? role;

  UserClass({
    required this.id,
    required this.name,
    required this.email,
    this.image, // Updated to be nullable
    this.emailVerifiedAt, // Updated to be nullable
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  UserClass copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
    String? emailVerifiedAt,
    String? roleId,
    String? createdAt,
    String? updatedAt,
    Role? role,
  }) =>
      UserClass(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        image: image ?? this.image,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        role: role ?? this.role,
      );

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    roleId: json["role_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    role: Role.fromJson(json["role"]),
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
    "role": role!.toJson(),
  };
}

class Role {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Role copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
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