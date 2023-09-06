// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transActionPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransActionPost _$TransActionPostFromJson(Map<String, dynamic> json) =>
    TransActionPost(
      price: json['price'] as String,
      type: json['type'] as String,
      categoryId: json['categoryId'] as int?,
      subCategoryId: json['subCategoryId'] as int?,
      account: json['account'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      currentDate: DateTime.parse(json['currentDate'] as String),
      memo: json['memo'] as String?,
      isBudget: json['isBudget'] as bool? ?? false,
    );

Map<String, dynamic> _$TransActionPostToJson(TransActionPost instance) =>
    <String, dynamic>{
      'price': instance.price,
      'type': instance.type,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
      'account': instance.account,
      'paymentMethod': instance.paymentMethod,
      'currentDate': instance.currentDate.toIso8601String(),
      'memo': instance.memo,
      'isBudget': instance.isBudget,
    };
