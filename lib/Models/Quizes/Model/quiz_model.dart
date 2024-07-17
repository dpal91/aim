// To parse this JSON data, do
//
//     final AllQuizzes = AllQuizzesFromJson(jsonString);

import 'dart:convert';

OpensQuizesModel opensQuizesModelFromJson(String str) =>
    OpensQuizesModel.fromJson(json.decode(str));

String opensQuizesModelToJson(OpensQuizesModel data) =>
    json.encode(data.toJson());

class OpensQuizesModel {
  OpensQuizesModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  final Data data;

  factory OpensQuizesModel.fromJson(Map<String, dynamic> json) =>
      OpensQuizesModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.pageTitle,
    required this.quizzes,
  });

  final String pageTitle;
  final Quizzes quizzes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["pageTitle"],
        quizzes: Quizzes.fromJson(json["quizzes"]),
      );

  Map<String, dynamic> toJson() => {
        "pageTitle": pageTitle,
        "quizzes": quizzes.toJson(),
      };
}

class Quizzes {
  Quizzes({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<Datum> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  factory Quizzes.fromJson(Map<String, dynamic> json) => Quizzes(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] ?? 0,
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? 0,
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.webinarId,
    required this.creatorId,
    required this.chapterId,
    required this.webinarTitle,
    required this.time,
    required this.attempt,
    required this.passMark,
    required this.certificate,
    required this.status,
    required this.totalMark,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.translations,
  });

  final int id;
  final int webinarId;
  final int creatorId;
  final int chapterId;
  final String webinarTitle;
  final int time;
  final dynamic attempt;
  final int passMark;
  final int certificate;
  final String status;
  final int totalMark;
  final int createdAt;
  final int updatedAt;
  final String title;
  final List<Translation> translations;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        webinarId: json["webinar_id"],
        creatorId: json["creator_id"],
        chapterId: json["chapter_id"] ?? 0,
        webinarTitle: json["webinar_title"] ?? "",
        time: json["time"] ?? 0,
        attempt: json["attempt"],
        passMark: json["pass_mark"],
        certificate: json["certificate"],
        status: json["status"],
        totalMark: json["total_mark"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        title: json["title"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "webinar_id": webinarId,
        "creator_id": creatorId,
        "chapter_id": chapterId,
        "webinar_title": webinarTitle,
        "time": time,
        "attempt": attempt,
        "pass_mark": passMark,
        "certificate": certificate,
        "status": status,
        "total_mark": totalMark,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    required this.id,
    required this.quizId,
    required this.locale,
    required this.title,
  });

  final int id;
  final int quizId;
  final String locale;
  final String title;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        quizId: json["quiz_id"],
        locale: json["locale"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "locale": locale,
        "title": title,
      };
}
