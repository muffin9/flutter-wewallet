import 'package:json_annotation/json_annotation.dart';

part 'transActionPost.g.dart';

@JsonSerializable()
class TransActionPost {
  final String price;
  final String type;
  final int? categoryId;
  final int? subCategoryId;
  final String? account;
  final String? paymentMethod;
  final DateTime currentDate;
  final String? memo;
  final bool isBudget;

  TransActionPost({
    required this.price,
    required this.type,
    this.categoryId,
    this.subCategoryId,
    this.account,
    this.paymentMethod,
    required this.currentDate,
    this.memo,
    this.isBudget = false,
  });

  factory TransActionPost.fromJson(Map<String, dynamic> json) =>
      _$TransActionPostFromJson(json);

  Map<String, dynamic> toJson() => _$TransActionPostToJson(this);
}
