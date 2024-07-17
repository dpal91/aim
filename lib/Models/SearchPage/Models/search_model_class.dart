class SearchModelClass {
  int? statusCode;
  String? message;
  List<Data>? data;

  SearchModelClass({this.statusCode, this.message, this.data});

  SearchModelClass.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? teacherId;
  int? creatorId;
  int? categoryId;
  String? type;
  int? private;
  String? slug;
  int? startDate;
  int? duration;
  String? timezone;
  String? thumbnail;
  String? imageCover;
  String? videoDemo;
  String? videoDemoSource;
  int? capacity;
  int? price;
  dynamic? organizationPrice;
  int? support;
  int? certificate;
  int? downloadable;
  int? partnerInstructor;
  int? subscribe;
  int? forum;
  int? accessDays;
  int? points;
  dynamic? messageForReviewer;
  String? status;
  int? createdAt;
  int? updatedAt;
  dynamic? deletedAt;
  String? title;
  String? description;
  String? seoDescription;
  List<Translations>? translations;

  Data(
      {this.id,
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
      this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    creatorId = json['creator_id'];
    categoryId = json['category_id'];
    type = json['type'];
    private = json['private'];
    slug = json['slug'];
    startDate = json['start_date'];
    duration = json['duration'];
    timezone = json['timezone'];
    thumbnail = json['thumbnail'];
    imageCover = json['image_cover'];
    videoDemo = json['video_demo'];
    videoDemoSource = json['video_demo_source'];
    capacity = json['capacity'];
    price = json['price'];
    organizationPrice = json['organization_price'];
    support = json['support'];
    certificate = json['certificate'];
    downloadable = json['downloadable'];
    partnerInstructor = json['partner_instructor'];
    subscribe = json['subscribe'];
    forum = json['forum'];
    accessDays = json['access_days'];
    points = json['points'];
    messageForReviewer = json['message_for_reviewer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    title = json['title'];
    description = json['description'];
    seoDescription = json['seo_description'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_id'] = teacherId;
    data['creator_id'] = creatorId;
    data['category_id'] = categoryId;
    data['type'] = type;
    data['private'] = private;
    data['slug'] = slug;
    data['start_date'] = startDate;
    data['duration'] = duration;
    data['timezone'] = timezone;
    data['thumbnail'] = thumbnail;
    data['image_cover'] = imageCover;
    data['video_demo'] = videoDemo;
    data['video_demo_source'] = videoDemoSource;
    data['capacity'] = capacity;
    data['price'] = price;
    data['organization_price'] = organizationPrice;
    data['support'] = support;
    data['certificate'] = certificate;
    data['downloadable'] = downloadable;
    data['partner_instructor'] = partnerInstructor;
    data['subscribe'] = subscribe;
    data['forum'] = forum;
    data['access_days'] = accessDays;
    data['points'] = points;
    data['message_for_reviewer'] = messageForReviewer;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['title'] = title;
    data['description'] = description;
    data['seo_description'] = seoDescription;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  int? webinarId;
  String? locale;
  String? title;
  String? seoDescription;
  String? description;

  Translations(
      {this.id,
      this.webinarId,
      this.locale,
      this.title,
      this.seoDescription,
      this.description});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webinarId = json['webinar_id'];
    locale = json['locale'];
    title = json['title'];
    seoDescription = json['seo_description'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['webinar_id'] = webinarId;
    data['locale'] = locale;
    data['title'] = title;
    data['seo_description'] = seoDescription;
    data['description'] = description;
    return data;
  }
}
