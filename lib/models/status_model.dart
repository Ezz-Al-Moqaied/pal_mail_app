import 'dart:convert';

StatusModel statusModelFromJson(String str) => StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
  List<StatusMails>? statuses;

  StatusModel({
    this.statuses,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
    statuses: json["statuses"] == null ? [] : List<StatusMails>.from(json["statuses"]!.map((x) => StatusMails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statuses": statuses == null ? [] : List<dynamic>.from(statuses!.map((x) => x.toJson())),
  };
}

class StatusMails {
  int? id;
  String? name;
  String? color;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;

  StatusMails({
    this.id,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
  });

  factory StatusMails.fromJson(Map<String, dynamic> json) => StatusMails(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    mailsCount: json["mails_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "mails_count": mailsCount,
  };
}
