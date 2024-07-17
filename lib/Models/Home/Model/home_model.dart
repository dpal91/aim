import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

class HomeModel {
  HomeModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.pageTitle,
    required this.pageRobot,
    required this.featureWebinars,
    required this.latestWebinars,
    required this.hasDiscountWebinars,
    required this.freeWebinars,
    required this.latestNotification,
    required this.upcomingNotification,
    required this.banners,
  });

  final String pageTitle;
  final String pageRobot;
  final dynamic featureWebinars;
  final List<Webinar> latestWebinars;
  final List<Webinar> hasDiscountWebinars;
  final List<Webinar> freeWebinars;
  final List<Job> latestNotification;
  final List<Job> upcomingNotification;
  final List<Map<String, dynamic>> banners;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["pageTitle"],
        pageRobot: json["pageRobot"],
        featureWebinars: json["featureWebinars"],
        latestWebinars: List<Webinar>.from(
            json["latestWebinars"].map((x) => Webinar.fromJson(x))),
        hasDiscountWebinars: List<Webinar>.from(
            json["hasDiscountWebinars"].map((x) => Webinar.fromJson(x))),
        freeWebinars: List<Webinar>.from(
            json["freeWebinars"].map((x) => Webinar.fromJson(x))),
        latestNotification: List<Job>.from(
            json["LatestNotification"].map((x) => Job.fromJson(x))),
        upcomingNotification: List<Job>.from(
            json["UpcomingNotification"].map((x) => Job.fromJson(x))),
        banners: List<Map<String, dynamic>>.from(
            json["advertisingBanners2"].map((x) => x)),
      );
}

class Webinar {
  Webinar({
    required this.type,
    required this.slug,
    required this.thumbnail,
    required this.price,
    required this.title,
    required this.description,
    required this.seoDescription,
    this.id,
  });

  final String? type;
  final String? slug;
  final String? thumbnail;
  final int? price;
  final dynamic title;
  final dynamic description;
  final dynamic seoDescription;
  final int? id;

  factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        type: json["type"],
        slug: json["slug"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        title: json["title"],
        description: json["description"],
        seoDescription: json["seo_description"],
        id: json["id"],
      );
}

class Job {
  Job({
    required this.id,
    required this.visitCount,
    required this.title,
    required this.content,
    required this.image,
  });

  final int id;
  final int visitCount;
  final String? title;
  final String? content;
  final String? image;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        visitCount: json["visit_count"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "visit_count": visitCount,
        "title": title,
        "content": content,
      };
}
