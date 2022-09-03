import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'categories.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdCategories {
  List<String> categories;

  SABnzbdCategories({
    required this.categories,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdCategories.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdCategoriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdCategoriesToJson(this);
  }
}
