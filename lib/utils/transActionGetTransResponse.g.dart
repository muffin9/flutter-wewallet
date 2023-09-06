// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transActionGetTransResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransActionGetTransResponse _$TransActionGetTransResponseFromJson(
        Map<String, dynamic> json) =>
    TransActionGetTransResponse(
      status: json['status'] as String,
      all: Map<String, num>.from(json['all'] as Map),
      date: (json['date'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Map<String, num>.from(e as Map)),
      ),
    );

Map<String, dynamic> _$TransActionGetTransResponseToJson(
        TransActionGetTransResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'all': instance.all,
      'date': instance.date,
    };
