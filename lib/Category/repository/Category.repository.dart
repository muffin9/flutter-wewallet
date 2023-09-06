import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/common/dio/dio.dart';
import 'package:flutter_wewallet/utils/categoryAllResponse.dart';
import 'package:retrofit/retrofit.dart';

part 'Category.repository.g.dart';

final CategoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = CategoryRepository(dio, baseUrl: 'http://$ip/category');

  return repository;
});

@RestApi()
abstract class CategoryRepository {
  factory CategoryRepository(Dio dio, {String baseUrl}) = _CategoryRepository;

  @GET('/all')
  @Headers({'access-token': 'true'})
  Future<CategoryAllResponse> getAllCategory();
}
