import 'package:json_annotation/json_annotation.dart';

part 'subCategory.g.dart';

@JsonSerializable()
class SubCategory {
  final num subCategoryId;
  final String subCategoryName;

  SubCategory({
    required this.subCategoryId,
    required this.subCategoryName,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
