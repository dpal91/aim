class TileCategory {
  late String imgUrl;
  late String title;
  late String subtitle;
  TileCategory(
      {required this.imgUrl, required this.title, required this.subtitle});
}

class SecondCourseBuilder {
  late String subtitle;
  late String nameOfTutor;
  late String time;
  late String price;
  SecondCourseBuilder({
    required this.subtitle,
    required this.nameOfTutor,
    required this.time,
    required this.price,
  });
}
