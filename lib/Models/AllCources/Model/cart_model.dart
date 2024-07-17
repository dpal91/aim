class CartModel {
  final int? statusCode;
  final String? message;
  final CartData? data;

  CartModel({
    this.statusCode,
    this.message,
    this.data,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? CartData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'statusCode': statusCode, 'message': message, 'data': data?.toJson()};
}

class CartData {
  final User? user;
  final List<Carts>? carts;
  final double? subTotal;
  final double? totalDiscount;
  final String? tax;
  final dynamic taxPrice;
  final dynamic total;
  final double? productDeliveryFee;
  final bool? taxIsDifferent;
  final dynamic userGroup;
  final List<dynamic>? hasPhysicalProduct;
  final double? deliveryEstimateTime;
  final List<Countries>? countries;
  final dynamic provinces;
  final dynamic cities;
  final dynamic districts;

  CartData({
    this.user,
    this.carts,
    this.subTotal,
    this.totalDiscount,
    this.tax,
    this.taxPrice,
    this.total,
    this.productDeliveryFee,
    this.taxIsDifferent,
    this.userGroup,
    this.hasPhysicalProduct,
    this.deliveryEstimateTime,
    this.countries,
    this.provinces,
    this.cities,
    this.districts,
  });

  CartData.fromJson(Map<String, dynamic> json)
      : user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        carts = (json['carts'] as List?)
            ?.map((dynamic e) => Carts.fromJson(e as Map<String, dynamic>))
            .toList(),
        subTotal = double.parse(json['subTotal'].toString()),
        totalDiscount = double.parse(json['totalDiscount'].toString()),
        tax = json['tax'] as String?,
        taxPrice = json['taxPrice'],
        total = json['total'],
        productDeliveryFee =
            double.parse(json['productDeliveryFee'].toString()),
        taxIsDifferent = json['taxIsDifferent'] as bool?,
        userGroup = json['userGroup'],
        hasPhysicalProduct = json['hasPhysicalProduct'] as List?,
        deliveryEstimateTime =
            double.parse(json['deliveryEstimateTime'].toString()),
        countries = (json['countries'] as List?)
            ?.map((dynamic e) => Countries.fromJson(e as Map<String, dynamic>))
            .toList(),
        provinces = json['provinces'],
        cities = json['cities'],
        districts = json['districts'];

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'carts': carts?.map((e) => e.toJson()).toList(),
        'subTotal': subTotal,
        'totalDiscount': totalDiscount,
        'tax': tax,
        'taxPrice': taxPrice,
        'total': total,
        'productDeliveryFee': productDeliveryFee,
        'taxIsDifferent': taxIsDifferent,
        'userGroup': userGroup,
        'hasPhysicalProduct': hasPhysicalProduct,
        'deliveryEstimateTime': deliveryEstimateTime,
        'countries': countries?.map((e) => e.toJson()).toList(),
        'provinces': provinces,
        'cities': cities,
        'districts': districts
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
  final String? avatarSettings;
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
  final dynamic userGroup;

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
    this.userGroup,
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
        avatarSettings = json['avatar_settings'] as String?,
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
        userGroup = json['user_group'];

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
        'user_group': userGroup
      };
}

class Carts {
  final int? id;
  final int? creatorId;
  final int? webinarId;
  final dynamic bundleId;
  final dynamic productOrderId;
  final dynamic reserveMeetingId;
  final dynamic subscribeId;
  final dynamic promotionId;
  final dynamic ticketId;
  final dynamic specialOfferId;
  final dynamic productDiscountId;
  final int? createdAt;
  final User? user;
  final Webinar? webinar;
  final dynamic reserveMeeting;
  final dynamic ticket;
  final dynamic productOrder;

  Carts({
    this.id,
    this.creatorId,
    this.webinarId,
    this.bundleId,
    this.productOrderId,
    this.reserveMeetingId,
    this.subscribeId,
    this.promotionId,
    this.ticketId,
    this.specialOfferId,
    this.productDiscountId,
    this.createdAt,
    this.user,
    this.webinar,
    this.reserveMeeting,
    this.ticket,
    this.productOrder,
  });

  Carts.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        creatorId = json['creator_id'] as int?,
        webinarId = json['webinar_id'] as int?,
        bundleId = json['bundle_id'],
        productOrderId = json['product_order_id'],
        reserveMeetingId = json['reserve_meeting_id'],
        subscribeId = json['subscribe_id'],
        promotionId = json['promotion_id'],
        ticketId = json['ticket_id'],
        specialOfferId = json['special_offer_id'],
        productDiscountId = json['product_discount_id'],
        createdAt = json['created_at'] as int?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        webinar = (json['webinar'] as Map<String, dynamic>?) != null
            ? Webinar.fromJson(json['webinar'] as Map<String, dynamic>)
            : null,
        reserveMeeting = json['reserve_meeting'],
        ticket = json['ticket'],
        productOrder = json['product_order'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'creator_id': creatorId,
        'webinar_id': webinarId,
        'bundle_id': bundleId,
        'product_order_id': productOrderId,
        'reserve_meeting_id': reserveMeetingId,
        'subscribe_id': subscribeId,
        'promotion_id': promotionId,
        'ticket_id': ticketId,
        'special_offer_id': specialOfferId,
        'product_discount_id': productDiscountId,
        'created_at': createdAt,
        'user': user?.toJson(),
        'webinar': webinar?.toJson(),
        'reserve_meeting': reserveMeeting,
        'ticket': ticket,
        'product_order': productOrder
      };
}

class CartUser {
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
  final String? avatarSettings;
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

  CartUser({
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

  CartUser.fromJson(Map<String, dynamic> json)
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
        avatarSettings = json['avatar_settings'] as String?,
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

class Webinar {
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
  final String? title;
  final String? description;
  final String? seoDescription;
  final List<Translations>? translations;

  Webinar({
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

  Webinar.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        teacherId = json['teacher_id'] as int?,
        creatorId = json['creator_id'] as int?,
        categoryId = json['category_id'] as int?,
        type = json['type'] as String?,
        private = json['private'] as int?,
        slug = json['slug'] as String?,
        startDate = json['start_date'] as int?,
        duration = json['duration'] as int?,
        timezone = json['timezone'] as String?,
        thumbnail = json['thumbnail'] as String?,
        imageCover = json['image_cover'] as String?,
        videoDemo = json['video_demo'] as String?,
        videoDemoSource = json['video_demo_source'] as String?,
        capacity = json['capacity'] as int?,
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
        title = json['title'] as String?,
        description = json['description'] as String?,
        seoDescription = json['seo_description'] as String?,
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
        'translations': translations?.map((e) => e.toJson()).toList()
      };
}

class Translations {
  final int? id;
  final int? webinarId;
  final String? locale;
  final String? title;
  final String? seoDescription;
  final String? description;

  Translations({
    this.id,
    this.webinarId,
    this.locale,
    this.title,
    this.seoDescription,
    this.description,
  });

  Translations.fromJson(Map<String, dynamic> json)
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

class Countries {
  final int? id;
  final dynamic countryId;
  final dynamic provinceId;
  final dynamic cityId;
  final String? geoCenter;
  final String? type;
  final String? title;
  final int? createdAt;

  Countries({
    this.id,
    this.countryId,
    this.provinceId,
    this.cityId,
    this.geoCenter,
    this.type,
    this.title,
    this.createdAt,
  });

  Countries.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        countryId = json['country_id'],
        provinceId = json['province_id'],
        cityId = json['city_id'],
        geoCenter = json['geo_center'] as String?,
        type = json['type'] as String?,
        title = json['title'] as String?,
        createdAt = json['created_at'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'country_id': countryId,
        'province_id': provinceId,
        'city_id': cityId,
        'geo_center': geoCenter,
        'type': type,
        'title': title,
        'created_at': createdAt
      };
}
