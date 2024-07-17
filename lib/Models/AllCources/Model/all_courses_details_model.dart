class AllCoursesDetailsModel {
  final int? statusCode;
  final String? message;
  final AllCoursesDetailsData? data;

  AllCoursesDetailsModel({
    this.statusCode,
    this.message,
    this.data,
  });

  AllCoursesDetailsModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? AllCoursesDetailsData.fromJson(
                json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'statusCode': statusCode, 'message': message, 'data': data?.toJson()};
}

class AllCoursesDetailsData {
  final String? pageTitle;
  final String? pageDescription;
  final String? pageRobot;
  final Course? course;
  final dynamic isFavorite;
  final bool? hasBought;
  final User? user;
  final int? webinarContentCount;
  final List<dynamic>? advertisingBanners;
  final List<AdvertisingBannersSidebar>? advertisingBannersSidebar;
  dynamic activeSpecialOffer;
  final List<dynamic>? sessionsWithoutChapter;
  final List<dynamic>? filesWithoutChapter;
  final List<dynamic>? textLessonsWithoutChapter;
  final List<dynamic>? quizzes;

  AllCoursesDetailsData({
    this.pageTitle,
    this.pageDescription,
    this.pageRobot,
    this.course,
    this.isFavorite,
    this.hasBought,
    this.user,
    this.webinarContentCount,
    this.advertisingBanners,
    this.advertisingBannersSidebar,
    this.activeSpecialOffer,
    this.sessionsWithoutChapter,
    this.filesWithoutChapter,
    this.textLessonsWithoutChapter,
    this.quizzes,
  });

  AllCoursesDetailsData.fromJson(Map<String, dynamic> json)
      : pageTitle = json['pageTitle'] as String?,
        pageDescription = json['pageDescription'] as String?,
        pageRobot = json['pageRobot'] as String?,
        course = (json['course'] as Map<String, dynamic>?) != null
            ? Course.fromJson(json['course'] as Map<String, dynamic>)
            : null,
        isFavorite = json['isFavorite'],
        hasBought = json['hasBought'] as bool?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        webinarContentCount = json['webinarContentCount'] as int?,
        advertisingBanners = json['advertisingBanners'] as List?,
        advertisingBannersSidebar = (json['advertisingBannersSidebar'] as List?)
            ?.map((dynamic e) =>
                AdvertisingBannersSidebar.fromJson(e as Map<String, dynamic>))
            .toList(),
        activeSpecialOffer = json['activeSpecialOffer'],
        sessionsWithoutChapter = json['sessionsWithoutChapter'] as List?,
        filesWithoutChapter = json['filesWithoutChapter'] as List?,
        textLessonsWithoutChapter = json['textLessonsWithoutChapter'] as List?,
        quizzes = json['course']['quizzes'];

  Map<String, dynamic> toJson() => {
        'pageTitle': pageTitle,
        'pageDescription': pageDescription,
        'pageRobot': pageRobot,
        'course': course?.toJson(),
        'isFavorite': isFavorite,
        'hasBought': hasBought,
        'user': user?.toJson(),
        'webinarContentCount': webinarContentCount,
        'advertisingBanners': advertisingBanners,
        'advertisingBannersSidebar':
            advertisingBannersSidebar?.map((e) => e.toJson()).toList(),
        'activeSpecialOffer': activeSpecialOffer,
        'sessionsWithoutChapter': sessionsWithoutChapter,
        'filesWithoutChapter': filesWithoutChapter,
        'textLessonsWithoutChapter': textLessonsWithoutChapter,
        'quizzes': quizzes
      };
}

class Course {
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
  final String? videoDemoSource;
  final dynamic capacity;
  final int? price;
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
  final int? salesCount;
  final int? noticeboardsCount;
  final String? title;
  final String? locale;
  final String? seoDescription;
  final String? description;
  final List<dynamic>? quizzes;
  final List<Tags>? tags;
  final List<dynamic>? prerequisites;
  final List<dynamic>? faqs;
  final List<WebinarExtraDescription>? webinarExtraDescription;
  final List<dynamic>? chapters;
  final List<dynamic>? files;
  final List<dynamic>? textLessons;
  final List<dynamic>? sessions;
  final List<dynamic>? assignments;
  final List<dynamic>? tickets;
  final List<dynamic>? filterOptions;
  final Category? category;
  final Teacher? teacher;
  final List<dynamic>? reviews;
  final List<dynamic>? comments;
  final List<dynamic>? webinarPartnerTeacher;
  final List<Translations>? translations;

  Course({
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
    this.salesCount,
    this.noticeboardsCount,
    this.title,
    this.locale,
    this.seoDescription,
    this.description,
    this.quizzes,
    this.tags,
    this.prerequisites,
    this.faqs,
    this.webinarExtraDescription,
    this.chapters,
    this.files,
    this.textLessons,
    this.sessions,
    this.assignments,
    this.tickets,
    this.filterOptions,
    this.category,
    this.teacher,
    this.reviews,
    this.comments,
    this.webinarPartnerTeacher,
    this.translations,
  });

  Course.fromJson(Map<String, dynamic> json)
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
        videoDemoSource = json['video_demo_source'] as String?,
        capacity = json['capacity'],
        price = json['price'] as int?,
        organizationPrice = json['organization_price'],
        support = json['support'] as int?,
        certificate = json['certificate'] as int?,
        downloadable = json['downloadable'] as int?,
        partnerInstructor = json['partner_instructor'] as int?,
        subscribe = json['subscribe'] as int?,
        forum = json['forum'] as int?,
        accessDays = json['access_days'] as int?,
        points = json['points'],
        messageForReviewer = json['message_for_reviewer'],
        status = json['status'] as String?,
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'] as int?,
        deletedAt = json['deleted_at'],
        salesCount = json['sales_count'] as int?,
        noticeboardsCount = json['noticeboards_count'] as int?,
        title = json['title'] as String?,
        locale = json['locale'] as String?,
        seoDescription = json['seo_description'] as String?,
        description = json['description'] as String?,
        quizzes = json['quizzes'] as List?,
        tags = (json['tags'] as List?)
            ?.map((dynamic e) => Tags.fromJson(e as Map<String, dynamic>))
            .toList(),
        prerequisites = json['prerequisites'] as List?,
        faqs = json['faqs'] as List?,
        webinarExtraDescription = (json['webinar_extra_description'] as List?)
            ?.map((dynamic e) =>
                WebinarExtraDescription.fromJson(e as Map<String, dynamic>))
            .toList(),
        chapters = json['chapters'] as List?,
        files = json['files'] as List?,
        textLessons = json['text_lessons'] as List?,
        sessions = json['sessions'] as List?,
        assignments = json['assignments'] as List?,
        tickets = json['tickets'] as List?,
        filterOptions = json['filter_options'] as List?,
        category = (json['category'] as Map<String, dynamic>?) != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        teacher = (json['teacher'] as Map<String, dynamic>?) != null
            ? Teacher.fromJson(json['teacher'] as Map<String, dynamic>)
            : null,
        reviews = json['reviews'] as List?,
        comments = json['comments'] as List?,
        webinarPartnerTeacher = json['webinar_partner_teacher'] as List?,
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
        'sales_count': salesCount,
        'noticeboards_count': noticeboardsCount,
        'title': title,
        'locale': locale,
        'seo_description': seoDescription,
        'description': description,
        'quizzes': quizzes,
        'tags': tags?.map((e) => e.toJson()).toList(),
        'prerequisites': prerequisites,
        'faqs': faqs,
        'webinar_extra_description':
            webinarExtraDescription?.map((e) => e.toJson()).toList(),
        'chapters': chapters,
        'files': files,
        'text_lessons': textLessons,
        'sessions': sessions,
        'assignments': assignments,
        'tickets': tickets,
        'filter_options': filterOptions,
        'category': category?.toJson(),
        'teacher': teacher?.toJson(),
        'reviews': reviews,
        'comments': comments,
        'webinar_partner_teacher': webinarPartnerTeacher,
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class Tags {
  final int? id;
  final String? title;
  final int? webinarId;
  final dynamic bundleId;

  Tags({
    this.id,
    this.title,
    this.webinarId,
    this.bundleId,
  });

  Tags.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        webinarId = json['webinar_id'] as int?,
        bundleId = json['bundle_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'webinar_id': webinarId,
        'bundle_id': bundleId
      };
}

class WebinarExtraDescription {
  final int? id;
  final int? creatorId;
  final int? webinarId;
  final String? type;
  final dynamic order;
  final int? createdAt;
  final String? value;
  final List<Translations>? translations;

  WebinarExtraDescription({
    this.id,
    this.creatorId,
    this.webinarId,
    this.type,
    this.order,
    this.createdAt,
    this.value,
    this.translations,
  });

  WebinarExtraDescription.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        creatorId = json['creator_id'] as int?,
        webinarId = json['webinar_id'] as int?,
        type = json['type'] as String?,
        order = json['order'],
        createdAt = json['created_at'] as int?,
        value = json['value'] as String?,
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'creator_id': creatorId,
        'webinar_id': webinarId,
        'type': type,
        'order': order,
        'created_at': createdAt,
        'value': value,
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class Translations {
  final int? id;
  final int? webinarExtraDescriptionId;
  final String? locale;
  final String? value;

  Translations({
    this.id,
    this.webinarExtraDescriptionId,
    this.locale,
    this.value,
  });

  Translations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        webinarExtraDescriptionId =
            json['webinar_extra_description_id'] as int?,
        locale = json['locale'] as String?,
        value = json['value'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'webinar_extra_description_id': webinarExtraDescriptionId,
        'locale': locale,
        'value': value
      };
}

class Category {
  final int? id;
  final int? parentId;
  final String? icon;
  final int? order;
  final String? title;
  final List<Translations>? translations;

  Category({
    this.id,
    this.parentId,
    this.icon,
    this.order,
    this.title,
    this.translations,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        parentId = json['parent_id'] as int?,
        icon = json['icon'] as String?,
        order = json['order'] as int?,
        title = json['title'] as String?,
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'icon': icon,
        'order': order,
        'title': title,
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class CategoryTranslations {
  final int? id;
  final int? categoryId;
  final String? locale;
  final String? title;

  CategoryTranslations({
    this.id,
    this.categoryId,
    this.locale,
    this.title,
  });

  CategoryTranslations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        categoryId = json['category_id'] as int?,
        locale = json['locale'] as String?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'category_id': categoryId, 'locale': locale, 'title': title};
}

class Teacher {
  final int? id;
  final dynamic courseCategoryId;
  final String? fullName;
  final String? roleName;
  final dynamic organId;
  final dynamic mobile;
  final String? email;
  final dynamic deviceToken;
  final dynamic deviceType;
  final dynamic profileImage;
  final dynamic bio;
  final int? verified;
  final int? financialApproval;
  final dynamic? avatar;
  final String? avatarSettings;
  final dynamic coverImg;
  final dynamic headline;
  final dynamic about;
  final dynamic address;
  final dynamic countryId;
  final dynamic provinceId;
  final dynamic cityId;
  final dynamic districtId;
  final dynamic location;
  final dynamic levelOfTraining;
  final String? meetingType;
  final String? status;
  final int? accessContent;
  final dynamic language;
  final dynamic timezone;
  final int? newsletter;
  final int? publicMessage;
  final dynamic accountType;
  final dynamic iban;
  final dynamic accountId;
  final dynamic identityScan;
  final dynamic certificate;
  final dynamic commission;
  final int? affiliate;
  final int? canCreateStore;
  final int? ban;
  final dynamic banStartAt;
  final dynamic banEndAt;
  final int? offline;
  final dynamic offlineMessage;
  final int? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Teacher({
    this.id,
    this.courseCategoryId,
    this.fullName,
    this.roleName,
    this.organId,
    this.mobile,
    this.email,
    this.deviceToken,
    this.deviceType,
    this.profileImage,
    this.bio,
    this.verified,
    this.financialApproval,
    this.avatar,
    this.avatarSettings,
    this.coverImg,
    this.headline,
    this.about,
    this.address,
    this.countryId,
    this.provinceId,
    this.cityId,
    this.districtId,
    this.location,
    this.levelOfTraining,
    this.meetingType,
    this.status,
    this.accessContent,
    this.language,
    this.timezone,
    this.newsletter,
    this.publicMessage,
    this.accountType,
    this.iban,
    this.accountId,
    this.identityScan,
    this.certificate,
    this.commission,
    this.affiliate,
    this.canCreateStore,
    this.ban,
    this.banStartAt,
    this.banEndAt,
    this.offline,
    this.offlineMessage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Teacher.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        courseCategoryId = json['course_category_id'],
        fullName = json['full_name'] as String?,
        roleName = json['role_name'] as String?,
        organId = json['organ_id'],
        mobile = json['mobile'],
        email = json['email'] as String?,
        deviceToken = json['device_token'],
        deviceType = json['device_type'],
        profileImage = json['profile_image'],
        bio = json['bio'],
        verified = json['verified'] as int?,
        financialApproval = json['financial_approval'] as int?,
        avatar = json['avatar'],
        avatarSettings = json['avatar_settings'] as String?,
        coverImg = json['cover_img'],
        headline = json['headline'],
        about = json['about'],
        address = json['address'],
        countryId = json['country_id'],
        provinceId = json['province_id'],
        cityId = json['city_id'],
        districtId = json['district_id'],
        location = json['location'],
        levelOfTraining = json['level_of_training'],
        meetingType = json['meeting_type'] as String?,
        status = json['status'] as String?,
        accessContent = json['access_content'] as int?,
        language = json['language'],
        timezone = json['timezone'],
        newsletter = json['newsletter'] as int?,
        publicMessage = json['public_message'] as int?,
        accountType = json['account_type'],
        iban = json['iban'],
        accountId = json['account_id'],
        identityScan = json['identity_scan'],
        certificate = json['certificate'],
        commission = json['commission'],
        affiliate = json['affiliate'] as int?,
        canCreateStore = json['can_create_store'] as int?,
        ban = json['ban'] as int?,
        banStartAt = json['ban_start_at'],
        banEndAt = json['ban_end_at'],
        offline = json['offline'] as int?,
        offlineMessage = json['offline_message'],
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'course_category_id': courseCategoryId,
        'full_name': fullName,
        'role_name': roleName,
        'organ_id': organId,
        'mobile': mobile,
        'email': email,
        'device_token': deviceToken,
        'device_type': deviceType,
        'profile_image': profileImage,
        'bio': bio,
        'verified': verified,
        'financial_approval': financialApproval,
        'avatar': avatar,
        'avatar_settings': avatarSettings,
        'cover_img': coverImg,
        'headline': headline,
        'about': about,
        'address': address,
        'country_id': countryId,
        'province_id': provinceId,
        'city_id': cityId,
        'district_id': districtId,
        'location': location,
        'level_of_training': levelOfTraining,
        'meeting_type': meetingType,
        'status': status,
        'access_content': accessContent,
        'language': language,
        'timezone': timezone,
        'newsletter': newsletter,
        'public_message': publicMessage,
        'account_type': accountType,
        'iban': iban,
        'account_id': accountId,
        'identity_scan': identityScan,
        'certificate': certificate,
        'commission': commission,
        'affiliate': affiliate,
        'can_create_store': canCreateStore,
        'ban': ban,
        'ban_start_at': banStartAt,
        'ban_end_at': banEndAt,
        'offline': offline,
        'offline_message': offlineMessage,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt
      };
}

class TeacherTranslations {
  final int? id;
  final int? webinarId;
  final String? locale;
  final String? title;
  final String? seoDescription;
  final String? description;

  TeacherTranslations({
    this.id,
    this.webinarId,
    this.locale,
    this.title,
    this.seoDescription,
    this.description,
  });

  TeacherTranslations.fromJson(Map<String, dynamic> json)
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

class User {
  final int? id;
  final int? courseCategoryId;
  final String? fullName;
  final String? roleName;
  final dynamic organId;
  final String? mobile;
  final String? email;
  final String? deviceToken;
  final int? deviceType;
  final String? profileImage;
  final dynamic bio;
  final int? verified;
  final int? financialApproval;
  final dynamic avatar;
  final dynamic avatarSettings;
  final dynamic coverImg;
  final dynamic headline;
  final String? about;
  final dynamic address;
  final dynamic countryId;
  final dynamic provinceId;
  final dynamic cityId;
  final dynamic districtId;
  final dynamic location;
  final dynamic levelOfTraining;
  final String? meetingType;
  final String? status;
  final int? accessContent;
  final dynamic language;
  final dynamic timezone;
  final int? newsletter;
  final int? publicMessage;
  final dynamic accountType;
  final dynamic iban;
  final dynamic accountId;
  final dynamic identityScan;
  final dynamic certificate;
  final dynamic commission;
  final int? affiliate;
  final int? canCreateStore;
  final int? ban;
  final dynamic banStartAt;
  final dynamic banEndAt;
  final int? offline;
  final String? offlineMessage;
  final int? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;
  final Role? role;

  User({
    this.id,
    this.courseCategoryId,
    this.fullName,
    this.roleName,
    this.organId,
    this.mobile,
    this.email,
    this.deviceToken,
    this.deviceType,
    this.profileImage,
    this.bio,
    this.verified,
    this.financialApproval,
    this.avatar,
    this.avatarSettings,
    this.coverImg,
    this.headline,
    this.about,
    this.address,
    this.countryId,
    this.provinceId,
    this.cityId,
    this.districtId,
    this.location,
    this.levelOfTraining,
    this.meetingType,
    this.status,
    this.accessContent,
    this.language,
    this.timezone,
    this.newsletter,
    this.publicMessage,
    this.accountType,
    this.iban,
    this.accountId,
    this.identityScan,
    this.certificate,
    this.commission,
    this.affiliate,
    this.canCreateStore,
    this.ban,
    this.banStartAt,
    this.banEndAt,
    this.offline,
    this.offlineMessage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        courseCategoryId = json['course_category_id'] as int?,
        fullName = json['full_name'] as String?,
        roleName = json['role_name'] as String?,
        organId = json['organ_id'],
        mobile = json['mobile'] as String?,
        email = json['email'] as String?,
        deviceToken = json['device_token'] as String?,
        deviceType = json['device_type'] as int?,
        profileImage = json['profile_image'] as String?,
        bio = json['bio'],
        verified = json['verified'] as int?,
        financialApproval = json['financial_approval'] as int?,
        avatar = json['avatar'],
        avatarSettings = json['avatar_settings'],
        coverImg = json['cover_img'],
        headline = json['headline'],
        about = json['about'] as String?,
        address = json['address'],
        countryId = json['country_id'],
        provinceId = json['province_id'],
        cityId = json['city_id'],
        districtId = json['district_id'],
        location = json['location'],
        levelOfTraining = json['level_of_training'],
        meetingType = json['meeting_type'] as String?,
        status = json['status'] as String?,
        accessContent = json['access_content'] as int?,
        language = json['language'],
        timezone = json['timezone'],
        newsletter = json['newsletter'] as int?,
        publicMessage = json['public_message'] as int?,
        accountType = json['account_type'],
        iban = json['iban'],
        accountId = json['account_id'],
        identityScan = json['identity_scan'],
        certificate = json['certificate'],
        commission = json['commission'],
        affiliate = json['affiliate'] as int?,
        canCreateStore = json['can_create_store'] as int?,
        ban = json['ban'] as int?,
        banStartAt = json['ban_start_at'],
        banEndAt = json['ban_end_at'],
        offline = json['offline'] as int?,
        offlineMessage = json['offline_message'] as String?,
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        role = (json['role'] as Map<String, dynamic>?) != null
            ? Role.fromJson(json['role'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'course_category_id': courseCategoryId,
        'full_name': fullName,
        'role_name': roleName,
        'organ_id': organId,
        'mobile': mobile,
        'email': email,
        'device_token': deviceToken,
        'device_type': deviceType,
        'profile_image': profileImage,
        'bio': bio,
        'verified': verified,
        'financial_approval': financialApproval,
        'avatar': avatar,
        'avatar_settings': avatarSettings,
        'cover_img': coverImg,
        'headline': headline,
        'about': about,
        'address': address,
        'country_id': countryId,
        'province_id': provinceId,
        'city_id': cityId,
        'district_id': districtId,
        'location': location,
        'level_of_training': levelOfTraining,
        'meeting_type': meetingType,
        'status': status,
        'access_content': accessContent,
        'language': language,
        'timezone': timezone,
        'newsletter': newsletter,
        'public_message': publicMessage,
        'account_type': accountType,
        'iban': iban,
        'account_id': accountId,
        'identity_scan': identityScan,
        'certificate': certificate,
        'commission': commission,
        'affiliate': affiliate,
        'can_create_store': canCreateStore,
        'ban': ban,
        'ban_start_at': banStartAt,
        'ban_end_at': banEndAt,
        'offline': offline,
        'offline_message': offlineMessage,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'role': role?.toJson()
      };
}

class Role {
  final int? id;
  final String? name;
  final String? caption;
  final int? usersCount;
  final int? isAdmin;
  final int? createdAt;

  Role({
    this.id,
    this.name,
    this.caption,
    this.usersCount,
    this.isAdmin,
    this.createdAt,
  });

  Role.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        caption = json['caption'] as String?,
        usersCount = json['users_count'] as int?,
        isAdmin = json['is_admin'] as int?,
        createdAt = json['created_at'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'caption': caption,
        'users_count': usersCount,
        'is_admin': isAdmin,
        'created_at': createdAt
      };
}

class AdvertisingBannersSidebar {
  final int? id;
  final String? position;
  final int? size;
  final String? link;
  final int? published;
  final int? createdAt;
  final String? title;
  final String? image;
  final List<Translations>? translations;

  AdvertisingBannersSidebar({
    this.id,
    this.position,
    this.size,
    this.link,
    this.published,
    this.createdAt,
    this.title,
    this.image,
    this.translations,
  });

  AdvertisingBannersSidebar.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        position = json['position'] as String?,
        size = json['size'] as int?,
        link = json['link'] as String?,
        published = json['published'] as int?,
        createdAt = json['created_at'] as int?,
        title = json['title'] as String?,
        image = json['image'] as String?,
        translations = (json['translations'] as List?)
            ?.map(
                (dynamic e) => Translations.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'position': position,
        'size': size,
        'link': link,
        'published': published,
        'created_at': createdAt,
        'title': title,
        'image': image,
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class AdvertisingBannersSidebarTranslations {
  final int? id;
  final int? advertisingBannerId;
  final String? locale;
  final String? title;
  final String? image;

  AdvertisingBannersSidebarTranslations({
    this.id,
    this.advertisingBannerId,
    this.locale,
    this.title,
    this.image,
  });

  AdvertisingBannersSidebarTranslations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        advertisingBannerId = json['advertising_banner_id'] as int?,
        locale = json['locale'] as String?,
        title = json['title'] as String?,
        image = json['image'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'advertising_banner_id': advertisingBannerId,
        'locale': locale,
        'title': title,
        'image': image
      };
}
