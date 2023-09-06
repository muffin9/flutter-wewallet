import 'package:json_annotation/json_annotation.dart';

part 'categoryAllResponse.g.dart';

@JsonSerializable()
class CategoryAllResponse {
  final String status;
  final List<dynamic>? allCategories;

  CategoryAllResponse({required this.status, this.allCategories});

  factory CategoryAllResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryAllResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryAllResponseToJson(this);
}
