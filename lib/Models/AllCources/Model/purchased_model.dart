class PurchasedModel {
  final int? statusCode;
  final String? message;
  final PurchasedData? data;

  PurchasedModel({
    this.statusCode,
    this.message,
    this.data,
  });

  PurchasedModel.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? PurchasedData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'statusCode': statusCode, 'message': message, 'data': data?.toJson()};
}

class PurchasedData {
  final String? pageTitle;
  final Sales? sales;
  final int? purchasedCount;
  final int? hours;
  final int? upComing;

  PurchasedData({
    this.pageTitle,
    this.sales,
    this.purchasedCount,
    this.hours,
    this.upComing,
  });

  PurchasedData.fromJson(Map<String, dynamic> json)
      : pageTitle = json['pageTitle'] as String?,
        sales = (json['sales'] as Map<String, dynamic>?) != null
            ? Sales.fromJson(json['sales'] as Map<String, dynamic>)
            : null,
        purchasedCount = json['purchasedCount'] as int?,
        hours = json['hours'] as int?,
        upComing = json['upComing'] as int?;

  Map<String, dynamic> toJson() => {
        'pageTitle': pageTitle,
        'sales': sales?.toJson(),
        'purchasedCount': purchasedCount,
        'hours': hours,
        'upComing': upComing
      };
}

class Sales {
  final int? currentPage;
  final List<SalesData>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Sales({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Sales.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as int?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => SalesData.fromJson(e as Map<String, dynamic>))
            .toList(),
        firstPageUrl = json['first_page_url'] as String?,
        from = json['from'] as int?,
        lastPage = json['last_page'] as int?,
        lastPageUrl = json['last_page_url'] as String?,
        nextPageUrl = json['next_page_url'],
        path = json['path'] as String?,
        perPage = json['per_page'] as int?,
        prevPageUrl = json['prev_page_url'],
        to = json['to'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total
      };
}

class SalesData {
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
  final dynamic bundle;

  SalesData({
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
    this.bundle,
  });

  SalesData.fromJson(Map<String, dynamic> json)
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
            : null,
        bundle = json['bundle'];

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
        'webinar': webinar?.toJson(),
        'bundle': bundle
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
  final int? salesCount;
  final String? title;
  final String? description;
  final String? seoDescription;
  final List<dynamic>? files;
  final List<dynamic>? reviews;
  final Category? category;
  final Teacher? teacher;
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
    this.salesCount,
    this.title,
    this.description,
    this.seoDescription,
    this.files,
    this.reviews,
    this.category,
    this.teacher,
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
        startDate = json['start_date'] ?? 0,
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
        salesCount = json['sales_count'] as int?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        seoDescription = json['seo_description'] as String?,
        files = json['files'] as List?,
        reviews = json['reviews'] as List?,
        category = (json['category'] as Map<String, dynamic>?) != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        teacher = (json['teacher'] as Map<String, dynamic>?) != null
            ? Teacher.fromJson(json['teacher'] as Map<String, dynamic>)
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
        'sales_count': salesCount,
        'title': title,
        'description': description,
        'seo_description': seoDescription,
        'files': files,
        'reviews': reviews,
        'category': category?.toJson(),
        'teacher': teacher?.toJson(),
        'translations': translations?.map((e) => e.toJson()).toList()
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

class Translations {
  final int? id;
  final int? categoryId;
  final String? locale;
  final String? title;

  Translations({
    this.id,
    this.categoryId,
    this.locale,
    this.title,
  });

  Translations.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        categoryId = json['category_id'] as int?,
        locale = json['locale'] as String?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'category_id': categoryId, 'locale': locale, 'title': title};
}

class Teacher {
  final int? id;
  final String? fullName;

  Teacher({
    this.id,
    this.fullName,
  });

  Teacher.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        fullName = json['full_name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'full_name': fullName};
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
