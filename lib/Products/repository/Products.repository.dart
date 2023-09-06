import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/common/dio/dio.dart';
import 'package:flutter_wewallet/utils/transActionGetTransResponse.dart';
import 'package:retrofit/retrofit.dart';

part 'Products.repository.g.dart';

final ProductsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = ProductsRepository(dio, baseUrl: 'http://$ip/transaction');

  return repository;
});

@RestApi()
abstract class ProductsRepository {
  factory ProductsRepository(Dio dio, {String baseUrl}) = _ProductsRepository;

  @GET('/')
  @Headers({'access-token': 'true'})
  Future<TransActionGetTransResponse> getProducts({
    @Query('month') required int month,
  });

  @POST('/')
  @Headers({'access-token': 'true'})
  Future<String> postProducts({
    @Body() required Map<String, dynamic> body,
  });
}
