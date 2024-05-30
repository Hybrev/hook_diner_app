class Category {
  final int? id;
  final String? title;
  final String? imageUrl;

  const Category({this.imageUrl, this.id, this.title});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        title: json['title'] as String?,
        imageUrl: json['image_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        "image_url": imageUrl,
      };
}
