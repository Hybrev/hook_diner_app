class Category {
  final int? id;
  final String? title;

  const Category({this.id, this.title});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}
