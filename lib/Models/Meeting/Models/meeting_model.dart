class MeetingModel {
  final int? statusCode;
  final String? message;
  final List<MeetingData>? data;

  MeetingModel({
    this.statusCode,
    this.message,
    this.data,
  });

  MeetingModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map(
                (dynamic e) => MeetingData.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class MeetingData {
  final int? id;
  final int? sellerId;
  final int? buyerId;
  final int? orderId;
  final int? webinarId;
  final dynamic bundleId;
  final dynamic meetingId;
  final dynamic subscribeId;
  final dynamic ticketId;
  final dynamic promotionId;
  final dynamic productOrderId;
  final dynamic registrationPackageId;
  final String? type;
  final String? paymentMethod;
  final dynamic amount;
  final String? tax;
  final String? commission;
  final String? discount;
  final String? totalAmount;
  final String? productDeliveryFee;
  final int? manualAdded;
  final int? accessToPurchasedItem;
  final int? createdAt;
  final dynamic refundAt;
  final Webinar? webinar;

  MeetingData({
    this.id,
    this.sellerId,
    this.buyerId,
    this.orderId,
    this.webinarId,
    this.bundleId,
    this.meetingId,
    this.subscribeId,
    this.ticketId,
    this.promotionId,
    this.productOrderId,
    this.registrationPackageId,
    this.type,
    this.paymentMethod,
    this.amount,
    this.tax,
    this.commission,
    this.discount,
    this.totalAmount,
    this.productDeliveryFee,
    this.manualAdded,
    this.accessToPurchasedItem,
    this.createdAt,
    this.refundAt,
    this.webinar,
  });

  MeetingData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        sellerId = json['seller_id'] as int?,
        buyerId = json['buyer_id'] as int?,
        orderId = json['order_id'] as int?,
        webinarId = json['webinar_id'] as int?,
        bundleId = json['bundle_id'],
        meetingId = json['meeting_id'],
        subscribeId = json['subscribe_id'],
        ticketId = json['ticket_id'],
        promotionId = json['promotion_id'],
        productOrderId = json['product_order_id'],
        registrationPackageId = json['registration_package_id'],
        type = json['type'] as String?,
        paymentMethod = json['payment_method'] as String?,
        amount = json['amount'],
        tax = json['tax'] as String?,
        commission = json['commission'] as String?,
        discount = json['discount'] as String?,
        totalAmount = json['total_amount'] as String?,
        productDeliveryFee = json['product_delivery_fee'] as String?,
        manualAdded = json['manual_added'] as int?,
        accessToPurchasedItem = json['access_to_purchased_item'] as int?,
        createdAt = json['created_at'] as int?,
        refundAt = json['refund_at'],
        webinar = (json['webinar'] as Map<String, dynamic>?) != null
            ? Webinar.fromJson(json['webinar'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'seller_id': sellerId,
        'buyer_id': buyerId,
        'order_id': orderId,
        'webinar_id': webinarId,
        'bundle_id': bundleId,
        'meeting_id': meetingId,
        'subscribe_id': subscribeId,
        'ticket_id': ticketId,
        'promotion_id': promotionId,
        'product_order_id': productOrderId,
        'registration_package_id': registrationPackageId,
        'type': type,
        'payment_method': paymentMethod,
        'amount': amount,
        'tax': tax,
        'commission': commission,
        'discount': discount,
        'total_amount': totalAmount,
        'product_delivery_fee': productDeliveryFee,
        'manual_added': manualAdded,
        'access_to_purchased_item': accessToPurchasedItem,
        'created_at': createdAt,
        'refund_at': refundAt,
        'webinar': webinar?.toJson()
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
  final List<dynamic>? sessions;
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
    this.sessions,
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
        sessions = json['sessions'] as List?,
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
        'sessions': sessions,
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
