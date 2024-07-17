// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.statusCode,
    required this.message,
    required this.trendingCategory,
    required this.browseCategory,
  });

  int statusCode;
  String message;
  List<TrendingCategory> trendingCategory;
  List<BrowseCategory> browseCategory;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        statusCode: json["statusCode"],
        message: json["message"],
        trendingCategory: List<TrendingCategory>.from(
            json["data"].map((x) => TrendingCategory.fromJson(x))),
        browseCategory: List<BrowseCategory>.from(
            json["browse_category"].map((x) => BrowseCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": List<dynamic>.from(trendingCategory.map((x) => x.toJson())),
        "browse_category":
            List<dynamic>.from(browseCategory.map((x) => x.toJson())),
      };
}

class BrowseCategory {
  BrowseCategory({
    required this.id,
    required this.parentId,
    required this.icon,
    required this.order,
    required this.webinarsCount,
    required this.title,
    required this.subCategories,
    required this.translations,
  });

  int id;
  int? parentId;
  String icon;
  int? order;
  int? webinarsCount;
  String title;
  List<BrowseCategory>? subCategories;
  List<Translation> translations;

  factory BrowseCategory.fromJson(Map<String, dynamic> json) => BrowseCategory(
        id: json["id"],
        parentId: json["parent_id"],
        icon: json["icon"] ?? "",
        order: json["order"],
        webinarsCount: json["webinars_count"],
        title: json["title"],
        subCategories: json["sub_categories"] == null
            ? null
            : List<BrowseCategory>.from(
                json["sub_categories"].map((x) => BrowseCategory.fromJson(x))),
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "icon": icon,
        "order": order,
        "webinars_count": webinarsCount,
        "title": title,
        "sub_categories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    required this.id,
    required this.categoryId,
    required this.locale,
    required this.title,
  });

  int id;
  int categoryId;
  Locale? locale;
  String title;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"],
        categoryId: json["category_id"],
        locale: localeValues.map[json["locale"]],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "locale": localeValues.reverse![locale],
        "title": title,
      };
}

// ignore: constant_identifier_names
enum Locale { EN, AR, ES }

final localeValues =
    EnumValues({"ar": Locale.AR, "en": Locale.EN, "es": Locale.ES});

class TrendingCategory {
  TrendingCategory({
    required this.id,
    required this.categoryId,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.category,
  });

  int id;
  int categoryId;
  String icon;
  String color;
  int createdAt;
  BrowseCategory category;

  factory TrendingCategory.fromJson(Map<String, dynamic> json) =>
      TrendingCategory(
        id: json["id"],
        categoryId: json["category_id"],
        icon: json["icon"],
        color: json["color"],
        createdAt: json["created_at"],
        category: BrowseCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "icon": icon,
        "color": color,
        "created_at": createdAt,
        "category": category.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
