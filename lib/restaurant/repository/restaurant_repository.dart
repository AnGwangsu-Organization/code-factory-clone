import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/common/dio/dio.dart';
import 'package:code_factory_clone/common/model/cursor_pagination_model.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
    (ref) {
      // dio가 변경되었을 경우 provider를 다시 build
      final dio = ref.watch(dioProvider);

      final repository = RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

      return repository;
    }
);

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl})
  = _RestaurantRepository;


  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPaginationModel<RestaurantModel>> paginate();

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}