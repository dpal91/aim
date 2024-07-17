// To parse this JSON data, do
//
//     final myResultsModel = myResultsModelFromJson(jsonString);

import 'dart:convert';

MyResultsModel myResultsModelFromJson(String str) =>
    MyResultsModel.fromJson(json.decode(str));

String myResultsModelToJson(MyResultsModel data) => json.encode(data.toJson());

class MyResultsModel {
  MyResultsModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  final Data data;

  factory MyResultsModel.fromJson(Map<String, dynamic> json) => MyResultsModel(
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
    required this.quizzesResults,
    required this.quizzesResultsCount,
    required this.passedCount,
    required this.failedCount,
    required this.waitingCount,
  });

  final String pageTitle;
  final QuizzesResults quizzesResults;
  final int quizzesResultsCount;
  final int passedCount;
  final int failedCount;
  final int waitingCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["pageTitle"],
        quizzesResults: QuizzesResults.fromJson(json["quizzesResults"]),
        quizzesResultsCount: json["quizzesResultsCount"],
        passedCount: json["passedCount"],
        failedCount: json["failedCount"],
        waitingCount: json["waitingCount"],
      );

  Map<String, dynamic> toJson() => {
        "pageTitle": pageTitle,
        "quizzesResults": quizzesResults.toJson(),
        "quizzesResultsCount": quizzesResultsCount,
        "passedCount": passedCount,
        "failedCount": failedCount,
        "waitingCount": waitingCount,
      };
}

class QuizzesResults {
  QuizzesResults({
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
  final String nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  factory QuizzesResults.fromJson(Map<String, dynamic> json) => QuizzesResults(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] ?? 0,
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"] ?? "",
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
    required this.quizId,
    required this.userId,
    required this.results,
    required this.userGrade,
    required this.status,
    required this.createdAt,
    required this.canTry,
    required this.quiz,
  });

  final int id;
  final int quizId;
  final int userId;
  final String results;
  final int userGrade;
  final String status;
  final int createdAt;
  final bool canTry;
  final Quiz quiz;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        quizId: json["quiz_id"],
        userId: json["user_id"],
        results: json["results"],
        userGrade: json["user_grade"],
        status: json["status"],
        createdAt: json["created_at"],
        canTry: json["can_try"],
        quiz: Quiz.fromJson(json["quiz"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "user_id": userId,
        "results": results,
        "user_grade": userGrade,
        "status": status,
        "created_at": createdAt,
        "can_try": canTry,
        "quiz": quiz.toJson(),
      };
}

class Quiz {
  Quiz({
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
    required this.quizQuestions,
    required this.creator,
    required this.webinar,
    required this.translations,
  });

  final int id;
  final int webinarId;
  final int creatorId;
  final int chapterId;
  final String? webinarTitle;
  final int time;
  final dynamic attempt;
  final int passMark;
  final int certificate;
  final String status;
  final int totalMark;
  final int createdAt;
  final dynamic updatedAt;
  final String title;
  final List<QuizQuestion> quizQuestions;
  final Creator creator;
  final Webinar webinar;
  final List<QuizTranslation> translations;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        webinarId: json["webinar_id"],
        creatorId: json["creator_id"],
        chapterId: json["chapter_id"] ?? 0,
        webinarTitle: json["webinar_title"],
        time: json["time"] ?? 0,
        attempt: json["attempt"],
        passMark: json["pass_mark"],
        certificate: json["certificate"],
        status: json["status"],
        totalMark: json["total_mark"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        title: json["title"],
        quizQuestions: List<QuizQuestion>.from(
            json["quiz_questions"].map((x) => QuizQuestion.fromJson(x))),
        creator: Creator.fromJson(json["creator"]),
        webinar: Webinar.fromJson(json["webinar"]),
        translations: List<QuizTranslation>.from(
            json["translations"].map((x) => QuizTranslation.fromJson(x))),
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
        "quiz_questions":
            List<dynamic>.from(quizQuestions.map((x) => x.toJson())),
        "creator": creator.toJson(),
        "webinar": webinar.toJson(),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Creator {
  Creator({
    required this.id,
    required this.courseCategoryId,
    required this.fullName,
    required this.roleName,
    required this.organId,
    required this.mobile,
    required this.email,
    required this.deviceToken,
    required this.deviceType,
    required this.profileImage,
    required this.bio,
    required this.verified,
    required this.financialApproval,
    required this.avatar,
    required this.avatarSettings,
    required this.coverImg,
    required this.headline,
    required this.about,
    required this.address,
    required this.countryId,
    required this.provinceId,
    required this.cityId,
    required this.districtId,
    required this.location,
    required this.levelOfTraining,
    required this.meetingType,
    required this.status,
    required this.accessContent,
    required this.language,
    required this.timezone,
    required this.newsletter,
    required this.publicMessage,
    required this.accountType,
    required this.iban,
    required this.accountId,
    required this.identityScan,
    required this.certificate,
    required this.commission,
    required this.affiliate,
    required this.canCreateStore,
    required this.ban,
    required this.banStartAt,
    required this.banEndAt,
    required this.offline,
    required this.offlineMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final int id;
  final dynamic courseCategoryId;
  final String fullName;
  final String roleName;
  final dynamic organId;
  final dynamic mobile;
  final String email;
  final dynamic deviceToken;
  final dynamic deviceType;
  final dynamic profileImage;
  final dynamic bio;
  final int verified;
  final int financialApproval;
  final dynamic avatar;
  final String avatarSettings;
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
  final String meetingType;
  final String status;
  final int accessContent;
  final dynamic language;
  final dynamic timezone;
  final int newsletter;
  final int publicMessage;
  final dynamic accountType;
  final dynamic iban;
  final dynamic accountId;
  final dynamic identityScan;
  final dynamic certificate;
  final dynamic commission;
  final int affiliate;
  final int canCreateStore;
  final int ban;
  final dynamic banStartAt;
  final dynamic banEndAt;
  final int offline;
  final dynamic offlineMessage;
  final int createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        courseCategoryId: json["course_category_id"],
        fullName: json["full_name"],
        roleName: json["role_name"],
        organId: json["organ_id"],
        mobile: json["mobile"],
        email: json["email"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        profileImage: json["profile_image"],
        bio: json["bio"],
        verified: json["verified"],
        financialApproval: json["financial_approval"],
        avatar: json["avatar"],
        avatarSettings: json["avatar_settings"],
        coverImg: json["cover_img"],
        headline: json["headline"],
        about: json["about"],
        address: json["address"],
        countryId: json["country_id"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        location: json["location"],
        levelOfTraining: json["level_of_training"],
        meetingType: json["meeting_type"],
        status: json["status"],
        accessContent: json["access_content"],
        language: json["language"],
        timezone: json["timezone"],
        newsletter: json["newsletter"],
        publicMessage: json["public_message"],
        accountType: json["account_type"],
        iban: json["iban"],
        accountId: json["account_id"],
        identityScan: json["identity_scan"],
        certificate: json["certificate"],
        commission: json["commission"],
        affiliate: json["affiliate"],
        canCreateStore: json["can_create_store"],
        ban: json["ban"],
        banStartAt: json["ban_start_at"],
        banEndAt: json["ban_end_at"],
        offline: json["offline"],
        offlineMessage: json["offline_message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_category_id": courseCategoryId,
        "full_name": fullName,
        "role_name": roleName,
        "organ_id": organId,
        "mobile": mobile,
        "email": email,
        "device_token": deviceToken,
        "device_type": deviceType,
        "profile_image": profileImage,
        "bio": bio,
        "verified": verified,
        "financial_approval": financialApproval,
        "avatar": avatar,
        "avatar_settings": avatarSettings,
        "cover_img": coverImg,
        "headline": headline,
        "about": about,
        "address": address,
        "country_id": countryId,
        "province_id": provinceId,
        "city_id": cityId,
        "district_id": districtId,
        "location": location,
        "level_of_training": levelOfTraining,
        "meeting_type": meetingType,
        "status": status,
        "access_content": accessContent,
        "language": language,
        "timezone": timezone,
        "newsletter": newsletter,
        "public_message": publicMessage,
        "account_type": accountType,
        "iban": iban,
        "account_id": accountId,
        "identity_scan": identityScan,
        "certificate": certificate,
        "commission": commission,
        "affiliate": affiliate,
        "can_create_store": canCreateStore,
        "ban": ban,
        "ban_start_at": banStartAt,
        "ban_end_at": banEndAt,
        "offline": offline,
        "offline_message": offlineMessage,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class QuizQuestion {
  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.creatorId,
    required this.grade,
    required this.type,
    required this.image,
    required this.video,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.correct,
    required this.translations,
  });

  final int id;
  final int quizId;
  final int creatorId;
  final String grade;
  final String type;
  final dynamic image;
  final dynamic video;
  final int createdAt;
  final dynamic updatedAt;
  final String title;
  final dynamic correct;
  final List<QuizQuestionTranslation> translations;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        id: json["id"],
        quizId: json["quiz_id"],
        creatorId: json["creator_id"],
        grade: json["grade"],
        type: json["type"],
        image: json["image"],
        video: json["video"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        title: json["title"],
        correct: json["correct"],
        translations: List<QuizQuestionTranslation>.from(json["translations"]
            .map((x) => QuizQuestionTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "creator_id": creatorId,
        "grade": grade,
        "type": type,
        "image": image,
        "video": video,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "correct": correct,
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class QuizQuestionTranslation {
  QuizQuestionTranslation({
    required this.id,
    required this.quizzesQuestionId,
    required this.locale,
    required this.title,
    required this.correct,
  });

  final int id;
  final int quizzesQuestionId;
  final String locale;
  final String title;
  final dynamic correct;

  factory QuizQuestionTranslation.fromJson(Map<String, dynamic> json) =>
      QuizQuestionTranslation(
        id: json["id"],
        quizzesQuestionId: json["quizzes_question_id"],
        locale: json["locale"],
        title: json["title"],
        correct: json["correct"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quizzes_question_id": quizzesQuestionId,
        "locale": locale,
        "title": title,
        "correct": correct,
      };
}

class QuizTranslation {
  QuizTranslation({
    required this.id,
    required this.quizId,
    required this.locale,
    required this.title,
  });

  final int id;
  final int quizId;
  final String locale;
  final String title;

  factory QuizTranslation.fromJson(Map<String, dynamic> json) =>
      QuizTranslation(
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

  final int id;
  final int teacherId;
  final int creatorId;
  final int categoryId;
  final String type;
  final int private;
  final String slug;
  final int startDate;
  final int duration;
  final String timezone;
  final String thumbnail;
  final String imageCover;
  final String videoDemo;
  final String videoDemoSource;
  final int capacity;
  final int price;
  final dynamic organizationPrice;
  final int support;
  final int certificate;
  final int downloadable;
  final int partnerInstructor;
  final int subscribe;
  final int forum;
  final int accessDays;
  final int points;
  final dynamic messageForReviewer;
  final String status;
  final int createdAt;
  final int updatedAt;
  final dynamic deletedAt;
  final String title;
  final String description;
  final String seoDescription;
  final List<WebinarTranslation> translations;

  factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
        id: json["id"],
        teacherId: json["teacher_id"],
        creatorId: json["creator_id"],
        categoryId: json["category_id"],
        type: json["type"],
        private: json["private"],
        slug: json["slug"],
        startDate: json["start_date"] ?? 0,
        duration: json["duration"],
        timezone: json["timezone"],
        thumbnail: json["thumbnail"],
        imageCover: json["image_cover"],
        videoDemo: json["video_demo"] ?? "",
        videoDemoSource: json["video_demo_source"] ?? "",
        capacity: json["capacity"] ?? 0,
        price: json["price"] ?? 0,
        organizationPrice: json["organization_price"],
        support: json["support"],
        certificate: json["certificate"],
        downloadable: json["downloadable"],
        partnerInstructor: json["partner_instructor"],
        subscribe: json["subscribe"],
        forum: json["forum"],
        accessDays: json["access_days"] ?? 0,
        points: json["points"] ?? 0,
        messageForReviewer: json["message_for_reviewer"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] ?? 0,
        deletedAt: json["deleted_at"],
        title: json["title"],
        description: json["description"],
        seoDescription: json["seo_description"] ?? "",
        translations: List<WebinarTranslation>.from(
            json["translations"].map((x) => WebinarTranslation.fromJson(x))),
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

class WebinarTranslation {
  WebinarTranslation({
    required this.id,
    required this.webinarId,
    required this.locale,
    required this.title,
    required this.seoDescription,
    required this.description,
  });

  final int id;
  final int webinarId;
  final String locale;
  final String title;
  final String seoDescription;
  final String description;

  factory WebinarTranslation.fromJson(Map<String, dynamic> json) =>
      WebinarTranslation(
        id: json["id"],
        webinarId: json["webinar_id"],
        locale: json["locale"],
        title: json["title"],
        seoDescription: json["seo_description"] ?? "",
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
