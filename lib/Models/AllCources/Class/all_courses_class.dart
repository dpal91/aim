class AdvanceExpandedListTile {
  late final String title;
  late String imgUrl;
  late final List<AdvanceExpandedListTile> tiles;
  late bool isExpanded;
  AdvanceExpandedListTile(
      {required this.title,
      required this.imgUrl,
      this.tiles = const [],
      this.isExpanded = false});
}
