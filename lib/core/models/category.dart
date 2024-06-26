class Category {
  final String? id;
  final String? title;
  final String? icon;

  const Category({this.icon, this.id, this.title});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as String?,
        title: json['title'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        "icon": icon,
      };
}
