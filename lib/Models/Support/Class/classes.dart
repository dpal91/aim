class AdvancedTile {
  late final String title;
  late final String subtitle;
  String imgUrl;
  late final List<AdvancedTile> tiles;
  late bool isExpanded;
  AdvancedTile(
      {required this.title,
      required this.subtitle,
      required this.imgUrl,
      this.tiles = const [],
      this.isExpanded = false});
}
