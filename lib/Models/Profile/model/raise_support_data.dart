// To parse this JSON data, do
//
//     final allSupportModel = allSupportModelFromJson(jsonString);

import 'dart:convert';

AllSupportModel allSupportModelFromJson(String str) =>
    AllSupportModel.fromJson(json.decode(str));

String allSupportModelToJson(AllSupportModel data) =>
    json.encode(data.toJson());

class AllSupportModel {
  AllSupportModel({
    this.statusCode,
    this.message,
    this.data,
  });

  final int? statusCode;
  final String? message;
  final Data? data;

  factory AllSupportModel.fromJson(Map<String, dynamic> json) =>
      AllSupportModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.pageTitle,
    this.departments,
    this.supports,
    this.supportsCount,
    this.openSupportsCount,
    this.closeSupportsCount,
  });

  final String? pageTitle;
  final List<Department>? departments;
  final List<Support>? supports;
  final int? supportsCount;
  final int? openSupportsCount;
  final int? closeSupportsCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["pageTitle"],
        departments: json["departments"] == null
            ? []
            : List<Department>.from(
                json["departments"]!.map((x) => Department.fromJson(x))),
        supports: json["supports"] == null
            ? []
            : List<Support>.from(
                json["supports"]!.map((x) => Support.fromJson(x))),
        supportsCount: json["supportsCount"],
        openSupportsCount: json["openSupportsCount"],
        closeSupportsCount: json["closeSupportsCount"],
      );

  Map<String, dynamic> toJson() => {
        "pageTitle": pageTitle,
        "departments": departments == null
            ? []
            : List<dynamic>.from(departments!.map((x) => x.toJson())),
        "supports": supports == null
            ? []
            : List<dynamic>.from(supports!.map((x) => x.toJson())),
        "supportsCount": supportsCount,
        "openSupportsCount": openSupportsCount,
        "closeSupportsCount": closeSupportsCount,
      };
}

class Department {
  Department({
    this.id,
    this.createdAt,
    this.title,
  });

  final int? id;
  final int? createdAt;
  final String? title;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        createdAt: json["created_at"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "title": title,
      };
}

class Support {
  Support({
    this.id,
    this.userId,
    this.webinarId,
    this.departmentId,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.department,
    this.conversations,
  });

  final int? id;
  final int? userId;
  final int? webinarId;
  final int? departmentId;
  final String? title;
  final String? status;
  final int? createdAt;
  final int? updatedAt;
  final User? user;
  final Department? department;
  final List<Conversation>? conversations;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        id: json["id"],
        userId: json["user_id"],
        webinarId: json["webinar_id"],
        departmentId: json["department_id"],
        title: json["title"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        department: json["department"] == null
            ? null
            : Department.fromJson(json["department"]),
        conversations: json["conversations"] == null
            ? []
            : List<Conversation>.from(
                json["conversations"]!.map((x) => Conversation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "webinar_id": webinarId,
        "department_id": departmentId,
        "title": title,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
        "department": department?.toJson(),
        "conversations": conversations == null
            ? []
            : List<dynamic>.from(conversations!.map((x) => x.toJson())),
      };
}

class Conversation {
  Conversation({
    this.id,
    this.supportId,
    this.supporterId,
    this.senderId,
    this.attach,
    this.message,
    this.createdAt,
  });

  final int? id;
  final int? supportId;
  final dynamic supporterId;
  final int? senderId;
  final dynamic attach;
  final String? message;
  final int? createdAt;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        supportId: json["support_id"],
        supporterId: json["supporter_id"],
        senderId: json["sender_id"],
        attach: json["attach"],
        message: json["message"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "support_id": supportId,
        "supporter_id": supporterId,
        "sender_id": senderId,
        "attach": attach,
        "message": message,
        "created_at": createdAt,
      };
}

class User {
  User({
    this.id,
    this.fullName,
    this.avatar,
    this.roleName,
  });

  final int? id;
  final String? fullName;
  final String? avatar;
  final String? roleName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        roleName: json["role_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "avatar": avatar,
        "role_name": roleName,
      };
}

// To parse this JSON data, do
//
//     final courseSupportModel = courseSupportModelFromJson(jsonString);

CourseSupportModel courseSupportModelFromJson(String str) =>
    CourseSupportModel.fromJson(json.decode(str));

String courseSupportModelToJson(CourseSupportModel data) =>
    json.encode(data.toJson());

class CourseSupportModel {
  CourseSupportModel({
    this.pageTitle,
    this.supports,
  });

  final String? pageTitle;
  final List<Support>? supports;

  factory CourseSupportModel.fromJson(Map<String, dynamic> json) =>
      CourseSupportModel(
        pageTitle: json["pageTitle"],
        supports: json["supports"] == null
            ? []
            : List<Support>.from(
                json["supports"]!.map((x) => Support.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageTitle": pageTitle,
        "supports": supports == null
            ? []
            : List<dynamic>.from(supports!.map((x) => x.toJson())),
      };
}

class Webinar {
  Webinar({
    this.id,
    this.title,
  });

  final int? id;
  final String? title;

  factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
