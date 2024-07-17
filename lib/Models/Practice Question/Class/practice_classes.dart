import 'package:flutter/cupertino.dart';

class ExpndAdvancedTile {
  late final String title;
  late final String subtitle;
  IconData iconData;
  late final List<ExpndAdvancedTile> tiles;
  late bool isExpanded;
  ExpndAdvancedTile(
      {required this.title,
      required this.subtitle,
      required this.iconData,
      this.tiles = const [],
      this.isExpanded = false});
}
