// To parse this JSON data, do
//
//     final currentAffairsModel = currentAffairsModelFromJson(jsonString);

import 'dart:convert';

CurrentAffairsModel currentAffairsModelFromJson(String str) =>
    CurrentAffairsModel.fromJson(json.decode(str));

String currentAffairsModelToJson(CurrentAffairsModel data) =>
    json.encode(data.toJson());

class CurrentAffairsModel {
  CurrentAffairsModel({
    required this.webinars,
  });

  final Webinars webinars;

  factory CurrentAffairsModel.fromJson(Map<String, dynamic> json) =>
      CurrentAffairsModel(
        webinars: Webinars.fromJson(json["webinars"]),
      );

  Map<String, dynamic> toJson() => {
        "webinars": webinars.toJson(),
      };
}

class Webinars {
  Webinars({
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

  final int? currentPage;
  final List<Datum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory Webinars.fromJson(Map<String, dynamic> json) => Webinars(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
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
    required this.tags,
    required this.translations,
  });

  final int? id;
  final int? teacherId;
  final int? creatorId;
  final int? categoryId;
  final String? type;
  final int? private;
  final String? slug;
  final int? startDate;
  final int? duration;
  final String? timezone;
  final String? thumbnail;
  final String? imageCover;
  final String? videoDemo;
  final String? videoDemoSource;
  final int? capacity;
  final dynamic price;
  final dynamic organizationPrice;
  final int? support;
  final int? certificate;
  final int? downloadable;
  final int? partnerInstructor;
  final int? subscribe;
  final int? forum;
  final int? accessDays;
  final dynamic points;
  final dynamic messageForReviewer;
  final String? status;
  final int? createdAt;
  final int? updatedAt;
  final dynamic deletedAt;
  final String? title;
  final String? description;
  final dynamic seoDescription;
  final List<Tag>? tags;
  final List<Translation>? translations;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        title: json["title"],
        description: json["description"],
        seoDescription: json["seo_description"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
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
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
        "translations":
            List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    required this.id,
    required this.title,
    required this.webinarId,
    required this.bundleId,
  });

  final int id;
  final String title;
  final int webinarId;
  final dynamic bundleId;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        title: json["title"],
        webinarId: json["webinar_id"],
        bundleId: json["bundle_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "webinar_id": webinarId,
        "bundle_id": bundleId,
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

  final int? id;
  final int? webinarId;
  final String? locale;
  final String? title;
  final dynamic seoDescription;
  final String? description;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        webinarId: json["webinar_id"],
        locale: json["locale"],
        title: json["title"],
        seoDescription: json["seo_description"],
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
