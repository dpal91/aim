import 'package:flutter/cupertino.dart';

class RoundCategory {
  String name;

  String icondata;

  RoundCategory({
    required this.name,
    required this.icondata,
  });
}

class CoursesCategories {
  late String subtitle;
  late String nameofTutor;
  late String time;
  late String price;
  late Widget courseStatus;
  CoursesCategories(
      {required this.subtitle,
      required this.nameofTutor,
      required this.time,
      required this.price,
      required this.courseStatus});
}

class Category {
  String imgUrl;
  late String categoryName;

  Category({required this.imgUrl, required this.categoryName});
}

class CategorySecond {
  late String title;
  late String date;

  CategorySecond({required this.title, required this.date});
}

class SubscriptionCategory {
  String title;
  String subtitle;
  String sub1;
  String sub2;
  String price;

  SubscriptionCategory({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.sub1,
    required this.sub2,
  });
}
