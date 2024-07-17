// To parse this JSON data, do
//
//     final bankDetailsModel = bankDetailsModelFromJson(jsonString);

import 'dart:convert';

AllCourseModel allCourseModelFromJson(String str) =>
    AllCourseModel.fromJson(json.decode(str));

String allCourseModelToJson(AllCourseModel data) => json.encode(data.toJson());

class AllCourseModel {
  AllCourseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  List<AllCourseData>? data;

  factory AllCourseModel.fromJson(Map<String, dynamic> json) => AllCourseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<AllCourseData>.from(
            json["data"].map((x) => AllCourseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllCourseData {
  AllCourseData({
    this.id,
    this.teacherId,
    this.creatorId,
    this.categoryId,
    this.type,
    this.private,
    this.slug,
    this.startDate,
    this.duration,
    this.timezone,
    this.thumbnail,
    this.imageCover,
    this.videoDemo,
    this.videoDemoSource,
    this.capacity,
    this.price,
    this.organizationPrice,
    this.support,
    this.certificate,
    this.downloadable,
    this.partnerInstructor,
    this.subscribe,
    this.forum,
    this.accessDays,
    this.points,
    this.messageForReviewer,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.description,
    this.seoDescription,
    this.translations,
  });

  dynamic id;
  dynamic teacherId;
  dynamic creatorId;
  dynamic categoryId;
  Type? type;
  dynamic private;
  dynamic slug;
  dynamic startDate;
  dynamic duration;
  Timezone? timezone;
  dynamic thumbnail;
  dynamic imageCover;
  dynamic videoDemo;
  dynamic videoDemoSource;
  dynamic capacity;
  dynamic price;
  dynamic organizationPrice;
  dynamic support;
  dynamic certificate;
  dynamic downloadable;
  dynamic partnerInstructor;
  dynamic subscribe;
  dynamic forum;
  dynamic accessDays;
  dynamic points;
  dynamic messageForReviewer;
  Status? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic title;
  dynamic description;
  dynamic seoDescription;
  List<Translation>? translations;

  factory AllCourseData.fromJson(Map<String, dynamic> json) => AllCourseData(
        id: json["id"],
        teacherId: json["teacher_id"],
        creatorId: json["creator_id"],
        categoryId: json["category_id"],
        type: typeValues.map[json["type"]],
        private: json["private"],
        slug: json["slug"],
        startDate: json["start_date"],
        duration: json["duration"],
        timezone: json["timezone"] == null
            ? null
            : timezoneValues.map[json["timezone"]],
        thumbnail: json["thumbnail"],
        imageCover: json["image_cover"],
        videoDemo: json["video_demo"],
        videoDemoSource: json["video_demo_source"],
        capacity: json["capacity"],
        price: json["price"],
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
        status: statusValues.map[json["status"]],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        title: json["title"],
        description: json["description"],
        seoDescription: json["seo_description"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "creator_id": creatorId,
        "category_id": categoryId,
        "type": typeValues.reverse[type],
        "private": private,
        "slug": slug,
        "start_date": startDate,
        "duration": duration,
        "timezone": timezone == null ? null : timezoneValues.reverse[timezone],
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
        "status": statusValues.reverse[status],
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "title": title,
        "description": description,
        "seo_description": seoDescription,
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

enum Status { ACTIVE, IS_DRAFT }

final statusValues =
    EnumValues({"active": Status.ACTIVE, "is_draft": Status.IS_DRAFT});

enum Timezone { AMERICA_NEW_YORK, ASIA_KOLKATA }

final timezoneValues = EnumValues({
  "America/New_York": Timezone.AMERICA_NEW_YORK,
  "Asia/Kolkata": Timezone.ASIA_KOLKATA
});

class Translation {
  Translation({
    this.id,
    this.webinarId,
    this.locale,
    this.title,
    this.seoDescription,
    this.description,
  });

  dynamic id;
  dynamic webinarId;
  Locale? locale;
  dynamic title;
  dynamic seoDescription;
  dynamic description;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        webinarId: json["webinar_id"],
        locale: localeValues.map[json["locale"]],
        title: json["title"],
        seoDescription: json["seo_description"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "webinar_id": webinarId,
        "locale": localeValues.reverse[locale],
        "title": title,
        "seo_description": seoDescription,
        "description": description,
      };
}

enum Locale { EN, ES, AR }

final localeValues =
    EnumValues({"ar": Locale.AR, "en": Locale.EN, "es": Locale.ES});

enum Type { COURSE, WEBINAR, TEXT_LESSON }

final typeValues = EnumValues({
  "course": Type.COURSE,
  "text_lesson": Type.TEXT_LESSON,
  "webinar": Type.WEBINAR
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
