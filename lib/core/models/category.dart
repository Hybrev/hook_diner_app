class Category {
  String? id;
  String? title;

  Category({
    this.id,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json, String id) => Category(
        id: json['id'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
