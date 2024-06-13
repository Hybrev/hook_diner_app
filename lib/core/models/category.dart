import 'package:flutter/material.dart';

class Category {
  final int? id;
  final String? title;
  final IconData? icon;

  const Category({this.icon, this.id, this.title});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        title: json['title'] as String?,
        icon: json['icon'] as IconData?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        "icon": icon,
      };
}
