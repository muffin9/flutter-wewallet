import 'package:json_annotation/json_annotation.dart';

part 'transActionGetTransResponse.g.dart';

@JsonSerializable()
class TransActionGetTransResponse {
  final String status;
  final Map<String, num> all;
  final Map<String, Map<String, num>> date;

  TransActionGetTransResponse({
    required this.status,
    required this.all,
    required this.date,
  });

  factory TransActionGetTransResponse.fromJson(Map<String, dynamic> json) =>
      _$TransActionGetTransResponseFromJson(json);
}
