class Category {
  String? id;
  String? title;
  // List<Item>? items;

  Category({
    this.id,
    this.title,
    /* this.items */
  });

  factory Category.fromJson(Map<String, dynamic> json, String id) => Category(
        id: json['id'] as String?,
        title: json['title'] as String?,
        // items: json['items'] as List<Item>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        // 'items': items?.map((v) => v.toJson()).toList(),
      };
}
