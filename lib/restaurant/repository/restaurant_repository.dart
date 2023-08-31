import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/common/dio/dio.dart';
import 'package:flutter_edu_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_edu_app/common/model/pagination_params.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantRepository(dio, baseUrl: '$address/restaurant');
});

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) = _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
});

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
