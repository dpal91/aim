class DescriptionModel {
  String descHtml;

  DescriptionModel({
    required this.descHtml,
  });

  factory DescriptionModel.fromJson(Map json) {
    return DescriptionModel(descHtml: json['data']['course']['slug']);
  }
}
