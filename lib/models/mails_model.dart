// To parse this JSON data, do
//
//     final mailsModel = mailsModelFromJson(jsonString);

import 'dart:convert';

MailsModel mailsModelFromJson(String str) => MailsModel.fromJson(json.decode(str));

String mailsModelToJson(MailsModel data) => json.encode(data.toJson());

class MailsModel {
  List<Mail>? mails;

  MailsModel({
    this.mails,
  });

  factory MailsModel.fromJson(Map<String, dynamic> json) => MailsModel(
    mails: json["mails"] == null ? [] : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mails": mails == null ? [] : List<dynamic>.from(mails!.map((x) => x.toJson())),
  };
}

class Mail {
  int? id;
  String? subject;
  String? description;
  String? senderId;
  String? archiveNumber;
  String? archiveDate;
  String? decision;
  String? statusId;
  String? finalDecision;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Status? status;
  List<Attachment>? attachments;
  List<Activity>? activities;
  List<Status>? tags;

  Mail({
    this.id,
    this.subject,
    this.description,
    this.senderId,
    this.archiveNumber,
    this.archiveDate,
    this.decision,
    this.statusId,
    this.finalDecision,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.status,
    this.attachments,
    this.activities,
    this.tags,
  });

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
    id: json["id"],
    subject: json["subject"],
    description: json["description"],
    senderId: json["sender_id"],
    archiveNumber: json["archive_number"],
    archiveDate: json["archive_date"],
    decision: json["decision"],
    statusId: json["status_id"],
    finalDecision: json["final_decision"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    tags: json["tags"] == null ? [] : List<Status>.from(json["tags"]!.map((x) => Status.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "description": description,
    "sender_id": senderId,
    "archive_number": archiveNumber,
    "archive_date": archiveDate,
    "decision": decision,
    "status_id": statusId,
    "final_decision": finalDecision,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "sender": sender?.toJson(),
    "status": status?.toJson(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
  };
}

class Activity {
  int? id;
  String? body;
  String? userId;
  String? mailId;
  dynamic sendNumber;
  dynamic sendDate;
  dynamic sendDestination;
  String? createdAt;
  String? updatedAt;
  User? user;

  Activity({
    this.id,
    this.body,
    this.userId,
    this.mailId,
    this.sendNumber,
    this.sendDate,
    this.sendDestination,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    body: json["body"],
    userId: json["user_id"],
    mailId: json["mail_id"],
    sendNumber: json["send_number"],
    sendDate: json["send_date"],
    sendDestination: json["send_destination"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "user_id": userId,
    "mail_id": mailId,
    "send_number": sendNumber,
    "send_date": sendDate,
    "send_destination": sendDestination,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toJson(),
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
  Status? role;

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
    role: json["role"] == null ? null : Status.fromJson(json["role"]),
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

class Status {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? color;
  Pivot? pivot;

  Status({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.pivot,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    color: json["color"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "color": color,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  String? mailId;
  String? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    mailId: json["mail_id"],
    tagId: json["tag_id"],
  );

  Map<String, dynamic> toJson() => {
    "mail_id": mailId,
    "tag_id": tagId,
  };
}

class Attachment {
  int? id;
  String? title;
  String? image;
  String? mailId;
  String? createdAt;
  String? updatedAt;

  Attachment({
    this.id,
    this.title,
    this.image,
    this.mailId,
    this.createdAt,
    this.updatedAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    mailId: json["mail_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "mail_id": mailId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Sender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  Status? category;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    categoryId: json["category_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    category: json["category"] == null ? null : Status.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "address": address,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category": category?.toJson(),
  };
}
