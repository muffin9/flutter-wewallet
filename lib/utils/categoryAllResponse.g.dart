// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryAllResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryAllResponse _$CategoryAllResponseFromJson(Map<String, dynamic> json) =>
    CategoryAllResponse(
      status: json['status'] as String,
      allCategories: json['allCategories'] as List<dynamic>?,
    );

Map<String, dynamic> _$CategoryAllResponseToJson(
        CategoryAllResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'allCategories': instance.allCategories,
    };
