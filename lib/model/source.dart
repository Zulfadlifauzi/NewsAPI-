class SourceModel {
  final String? id;
  final String? name;
  final String? description;
  final String? url;
  final String? category;
  final String? country;
  final String? language;

  SourceModel(this.id, this.description, this.category, this.country,
      this.language, this.name, this.url);

  SourceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        url = json['url'],
        category = json['category'],
        country = json['country'],
        language = json['language'];
}
