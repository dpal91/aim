class SubscriptionModel {
  int? statusCode;
  String? message;
  SubscriptionModelData? data;

  SubscriptionModel({this.statusCode, this.message, this.data});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null
        ? SubscriptionModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubscriptionModelData {
  String? pageTitle;
  List<Subscribes>? subscribes;
  bool? activeSubscribe;
  int? dayOfUse;

  SubscriptionModelData(
      {this.pageTitle, this.subscribes, this.activeSubscribe, this.dayOfUse});

  SubscriptionModelData.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    if (json['subscribes'] != null) {
      subscribes = <Subscribes>[];
      json['subscribes'].forEach((v) {
        subscribes!.add(Subscribes.fromJson(v));
      });
    }
    activeSubscribe = json['activeSubscribe'];
    dayOfUse = json['dayOfUse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageTitle'] = pageTitle;
    if (subscribes != null) {
      data['subscribes'] = subscribes!.map((v) => v.toJson()).toList();
    }
    data['activeSubscribe'] = activeSubscribe;
    data['dayOfUse'] = dayOfUse;
    return data;
  }
}

class Subscribes {
  int? id;
  int? usableCount;
  int? days;
  int? price;
  String? icon;
  int? isPopular;
  int? infiniteUse;
  int? createdAt;
  String? title;
  String? description;
  List<Translations>? translations;

  Subscribes(
      {this.id,
      this.usableCount,
      this.days,
      this.price,
      this.icon,
      this.isPopular,
      this.infiniteUse,
      this.createdAt,
      this.title,
      this.description,
      this.translations});

  Subscribes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usableCount = json['usable_count'];
    days = json['days'];
    price = json['price'];
    icon = json['icon'];
    isPopular = json['is_popular'];
    infiniteUse = json['infinite_use'];
    createdAt = json['created_at'];
    title = json['title'];
    description = json['description'];
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
    data['usable_count'] = usableCount;
    data['days'] = days;
    data['price'] = price;
    data['icon'] = icon;
    data['is_popular'] = isPopular;
    data['infinite_use'] = infiniteUse;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? id;
  int? subscribeId;
  String? locale;
  String? title;
  String? description;

  Translations(
      {this.id, this.subscribeId, this.locale, this.title, this.description});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscribeId = json['subscribe_id'];
    locale = json['locale'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subscribe_id'] = subscribeId;
    data['locale'] = locale;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
