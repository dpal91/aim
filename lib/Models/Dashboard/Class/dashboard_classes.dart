import 'package:flutter/cupertino.dart';

class CommonCard {
  late IconData iconData;
  late String number;
  late String courses;
  Color color;

  CommonCard(
      {required this.iconData,
      required this.number,
      required this.courses,
      required this.color});
}

class CarouselBalance {
  late String title;
  late String subtitle;
  late IconData iconData;
  late Color colors;
  CarouselBalance(
      {required this.title,
      required this.subtitle,
      required this.iconData,
      required this.colors});
}
