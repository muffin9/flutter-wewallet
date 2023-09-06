import 'package:flutter_wewallet/utils/subCategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final num categoryId;
  final String categoryName;
  final String categoryImageUrl;
  @JsonKey(defaultValue: <SubCategory>[])
  final List<SubCategory> subCategory;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.subCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
