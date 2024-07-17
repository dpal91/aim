class ChapterModel {
  final int? statusCode;
  final String? message;
  final ChapterData? data;

  ChapterModel({
    this.statusCode,
    this.message,
    this.data,
  });

  ChapterModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? ChapterData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'statusCode': statusCode, 'message': message, 'data': data?.toJson()};
}

class ChapterData {
  final int? id;
  final int? teacherId;
  final int? creatorId;
  final int? categoryId;
  final String? type;
  final int? private;
  final String? slug;
  final dynamic startDate;
  final int? duration;
  final String? timezone;
  final String? thumbnail;
  final String? imageCover;
  final String? videoDemo;
  final dynamic videoDemoSource;
  final dynamic capacity;
  final int? price;
  final dynamic organizationPrice;
  final int? support;
  final int? certificate;
  final int? downloadable;
  final int? partnerInstructor;
  final int? subscribe;
  final int? forum;
  final dynamic accessDays;
  final int? points;
  final String? messageForReviewer;
  final String? status;
  final int? createdAt;
  final int? updatedAt;
  final dynamic deletedAt;
  final String? title;
  final String? description;
  final String? seoDescription;
  final Teacher? teacher;
  final List<Reviews>? reviews;
  final List<dynamic>? tickets;
  final Feature? feature;
  final List<Translations>? translations;

  ChapterData({
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
    this.teacher,
    this.reviews,
    this.tickets,
    this.feature,
    this.translations,
  });

  ChapterData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        teacherId = json['teacher_id'] as int?,
        creatorId = json['creator_id'] as int?,
        categoryId = json['category_id'] as int?,
        type = json['type'] as String?,
        private = json['private'] as int?,
        slug = json['slug'] as String?,
        startDate = json['start_date'],
        duration = json['duration'] as int?,
        timezone = json['timezone'] as String?,
        thumbnail = json['thumbnail'] as String?,
        imageCover = json['image_cover'] as String?,
        videoDemo = json['video_demo'] as String?,
        videoDemoSource = json['video_demo_source'],
        capacity = json['capacity'],
        price = json['price'] as int?,
        organizationPrice = json['organization_price'],
        support = json['support'] as int?,
        certificate = json['certificate'] as int?,
        downloadable = json['downloadable'] as int?,
        partnerInstructor = json['partner_instructor'] as int?,
        subscribe = json['subscribe'] as int?,
        forum = json['forum'] as int?,
        accessDays = json['access_days'],
        points = json['points'] as int?,
        messageForReviewer = json['message_for_reviewer'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'] as int?,
        deletedAt = json['deleted_at'],
        title = json['title'] as String?,
        description = json['description'] as String?,
        seoDescription = json['seo_description'] as String?,
        teacher = (json['teacher'] as Map<String, dynamic>?) != null
            ? Teacher.fromJson(json['teacher'] as Map<String, dynamic>)
            : null,
        reviews = (json['reviews'] as List?)
            ?.map((dynamic e) => Reviews.fromJson(e as Map<String, dynamic>))
            .toList(),
        tickets = json['tickets'] as List?,
        feature = (json['feature'] as Map<String, dynamic>?) != null
            ? Feature.fromJson(json['feature'] as Map<String, dynamic>)
            : null,
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'teacher_id': teacherId,
        'creator_id': creatorId,
        'category_id': categoryId,
        'type': type,
        'private': private,
        'slug': slug,
        'start_date': startDate,
        'duration': duration,
        'timezone': timezone,
        'thumbnail': thumbnail,
        'image_cover': imageCover,
        'video_demo': videoDemo,
        'video_demo_source': videoDemoSource,
        'capacity': capacity,
        'price': price,
        'organization_price': organizationPrice,
        'support': support,
        'certificate': certificate,
        'downloadable': downloadable,
        'partner_instructor': partnerInstructor,
        'subscribe': subscribe,
        'forum': forum,
        'access_days': accessDays,
        'points': points,
        'message_for_reviewer': messageForReviewer,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'title': title,
        'description': description,
        'seo_description': seoDescription,
        'teacher': teacher?.toJson(),
        'reviews': reviews?.map((e) => e.toJson()).toList(),
        'tickets': tickets,
        'feature': feature?.toJson(),
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class Teacher {
  final int? id;
  final String? fullName;
  final String? avatar;

  Teacher({
    this.id,
    this.fullName,
    this.avatar,
  });

  Teacher.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        fullName = json['full_name'] as String?,
        avatar = json['avatar'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'full_name': fullName, 'avatar': avatar};
}

class Reviews {
  final int? id;
  final int? creatorId;
  final int? webinarId;
  final dynamic bundleId;
  final int? contentQuality;
  final int? instructorSkills;
  final int? purchaseWorth;
  final int? supportQuality;
  final String? rates;
  final String? description;
  final int? createdAt;
  final String? status;

  Reviews({
    this.id,
    this.creatorId,
    this.webinarId,
    this.bundleId,
    this.contentQuality,
    this.instructorSkills,
    this.purchaseWorth,
    this.supportQuality,
    this.rates,
    this.description,
    this.createdAt,
    this.status,
  });

  Reviews.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        creatorId = json['creator_id'] as int?,
        webinarId = json['webinar_id'] as int?,
        bundleId = json['bundle_id'],
        contentQuality = json['content_quality'] as int?,
        instructorSkills = json['instructor_skills'] as int?,
        purchaseWorth = json['purchase_worth'] as int?,
        supportQuality = json['support_quality'] as int?,
        rates = json['rates'] as String?,
        description = json['description'] as String?,
        createdAt = json['created_at'] as int?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'creator_id': creatorId,
        'webinar_id': webinarId,
        'bundle_id': bundleId,
        'content_quality': contentQuality,
        'instructor_skills': instructorSkills,
        'purchase_worth': purchaseWorth,
        'support_quality': supportQuality,
        'rates': rates,
        'description': description,
        'created_at': createdAt,
        'status': status
      };
}

class Feature {
  final int? id;
  final int? webinarId;
  final String? page;
  final String? status;
  final int? updatedAt;
  final dynamic description;
  final List<Translations>? translations;

  Feature({
    this.id,
    this.webinarId,
    this.page,
    this.status,
    this.updatedAt,
    this.description,
    this.translations,
  });

  Feature.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        webinarId = json['webinar_id'] as int?,
        page = json['page'] as String?,
        status = json['status'] as String?,
        updatedAt = json['updated_at'] as int?,
        description = json['description'],
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'webinar_id': webinarId,
        'page': page,
        'status': status,
        'updated_at': updatedAt,
        'description': description,
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class Translations {
  final int? id;
  final int? featureWebinarId;
  final String? locale;
  final dynamic description;

  Translations({
    this.id,
    this.featureWebinarId,
    this.locale,
    this.description,
  });

  Translations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        featureWebinarId = json['feature_webinar_id'] as int?,
        locale = json['locale'] as String?,
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'feature_webinar_id': featureWebinarId,
        'locale': locale,
        'description': description
      };
}

class Translations1 {
  final int? id;
  final int? webinarId;
  final String? locale;
  final String? title;
  final String? seoDescription;
  final String? description;

  Translations1({
    this.id,
    this.webinarId,
    this.locale,
    this.title,
    this.seoDescription,
    this.description,
  });

  Translations1.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        webinarId = json['webinar_id'] as int?,
        locale = json['locale'] as String?,
        title = json['title'] as String?,
        seoDescription = json['seo_description'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'webinar_id': webinarId,
        'locale': locale,
        'title': title,
        'seo_description': seoDescription,
        'description': description
      };
}
