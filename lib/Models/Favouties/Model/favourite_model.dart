// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'dart:convert';

FavouriteModel favouriteModelFromJson(String str) =>
    FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
  FavouriteModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  int statusCode;
  String message;
  List<FavouriteData> data;

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<FavouriteData>.from(
            json["data"].map((x) => FavouriteData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FavouriteData {
  FavouriteData({
    required this.id,
    required this.userId,
    required this.webinarId,
    required this.bundleId,
    required this.createdAt,
    required this.webinar,
  });

  int id;
  int userId;
  int webinarId;
  dynamic bundleId;
  int createdAt;
  Webinar webinar;

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
        id: json["id"],
        userId: json["user_id"],
        webinarId: json["webinar_id"],
        bundleId: json["bundle_id"],
        createdAt: json["created_at"],
        webinar: Webinar.fromJson(json["webinar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "webinar_id": webinarId,
        "bundle_id": bundleId,
        "created_at": createdAt,
        "webinar": webinar.toJson(),
      };
}

class Webinar {
  Webinar({
    required this.id,
    required this.teacherId,
    required this.creatorId,
    required this.categoryId,
    required this.type,
    required this.private,
    required this.slug,
    required this.startDate,
    required this.duration,
    required this.timezone,
    required this.thumbnail,
    required this.imageCover,
    required this.videoDemo,
    required this.videoDemoSource,
    required this.capacity,
    required this.price,
    required this.organizationPrice,
    required this.support,
    required this.certificate,
    required this.downloadable,
    required this.partnerInstructor,
    required this.subscribe,
    required this.forum,
    required this.accessDays,
    required this.points,
    required this.messageForReviewer,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.description,
    required this.seoDescription,
    required this.translations,
  });

  int id;
  int teacherId;
  int creatorId;
  int categoryId;
  String type;
  int private;
  String slug;
  dynamic startDate;
  int duration;
  dynamic timezone;
  String thumbnail;
  String imageCover;
  String videoDemo;
  dynamic videoDemoSource;
  dynamic capacity;
  int price;
  dynamic organizationPrice;
  int support;
  int certificate;
  int downloadable;
  int partnerInstructor;
  int subscribe;
  int forum;
  dynamic accessDays;
  dynamic points;
  dynamic messageForReviewer;
  String status;
  int createdAt;
  int updatedAt;
  dynamic deletedAt;
  String title;
  String description;
  String seoDescription;
  List<Translation> translations;

  factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        id: json["id"],
        teacherId: json["teacher_id"],
        creatorId: json["creator_id"],
        categoryId: json["category_id"],
        type: json["type"],
        private: json["private"],
        slug: json["slug"],
        startDate: json["start_date"],
        duration: json["duration"],
        timezone: json["timezone"],
        thumbnail: json["thumbnail"],
        imageCover: json["image_cover"],
        videoDemo: json["video_demo"],
        videoDemoSource: json["video_demo_source"],
        capacity: json["capacity"],
        price: json["price"] ?? 0,
        organizationPrice: json["organization_price"],
        support: json["support"],
        certificate: json["certificate"],
        downloadable: json["downloadable"],
        partnerInstructor: json["partner_instructor"],
        subscribe: json["subscribe"],
        forum: json["forum"],
        accessDays: json["access_days"],
        points: json["points"],
        messageForReviewer: json["message_for_reviewer"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        seoDescription: json["seo_description"] ?? '',
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "creator_id": creatorId,
        "category_id": categoryId,
        "type": type,
        "private": private,
        "slug": slug,
        "start_date": startDate,
        "duration": duration,
        "timezone": timezone,
        "thumbnail": thumbnail,
        "image_cover": imageCover,
        "video_demo": videoDemo,
        "video_demo_source": videoDemoSource,
        "capacity": capacity,
        "price": price,
        "organization_price": organizationPrice,
        "support": support,
        "certificate": certificate,
        "downloadable": downloadable,
        "partner_instructor": partnerInstructor,
        "subscribe": subscribe,
        "forum": forum,
        "access_days": accessDays,
        "points": points,
        "message_for_reviewer": messageForReviewer,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "title": title,
        "description": description,
        "seo_description": seoDescription,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    required this.id,
    required this.webinarId,
    required this.locale,
    required this.title,
    required this.seoDescription,
    required this.description,
  });

  int id;
  int webinarId;
  String locale;
  String title;
  String seoDescription;
  String description;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        webinarId: json["webinar_id"],
        locale: json["locale"],
        title: json["title"],
        seoDescription: json["seo_description"] ?? '',
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "webinar_id": webinarId,
        "locale": locale,
        "title": title,
        "seo_description": seoDescription,
        "description": description,
      };
}
