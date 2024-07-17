// To parse this JSON data, do
//
//     final supportwebinarandContentModel = supportwebinarandContentModelFromJson(jsonString);

import 'dart:convert';

SupportwebinarandContentModel supportwebinarandContentModelFromJson(
        String str) =>
    SupportwebinarandContentModel.fromJson(json.decode(str));

String supportwebinarandContentModelToJson(
        SupportwebinarandContentModel data) =>
    json.encode(data.toJson());

class SupportwebinarandContentModel {
  SupportwebinarandContentModel({
    this.pageTitle,
    this.departments,
    this.webinars,
  });

  final String? pageTitle;
  final List<Department>? departments;
  final List<Webinar>? webinars;

  factory SupportwebinarandContentModel.fromJson(Map<String, dynamic> json) =>
      SupportwebinarandContentModel(
        pageTitle: json["pageTitle"],
        departments: json["departments"] == null
            ? []
            : List<Department>.from(
                json["departments"]!.map((x) => Department.fromJson(x))),
        webinars: json["webinars"] == null
            ? []
            : List<Webinar>.from(
                json["webinars"]!.map((x) => Webinar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageTitle": pageTitle,
        "departments": departments == null
            ? []
            : List<dynamic>.from(departments!.map((x) => x.toJson())),
        "webinars": webinars == null
            ? []
            : List<dynamic>.from(webinars!.map((x) => x.toJson())),
      };
}

class Department {
  Department({
    this.id,
    this.title,
  });

  final int? id;
  final String? title;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class DepartmentTranslation {
  DepartmentTranslation({
    this.id,
    this.supportDepartmentId,
    this.locale,
    this.title,
  });

  final int? id;
  final int? supportDepartmentId;
  final String? locale;
  final String? title;

  factory DepartmentTranslation.fromJson(Map<String, dynamic> json) =>
      DepartmentTranslation(
        id: json["id"],
        supportDepartmentId: json["support_department_id"],
        locale: json["locale"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "support_department_id": supportDepartmentId,
        "locale": locale,
        "title": title,
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
