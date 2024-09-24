import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:code_factory_clone/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
    (ref) {
      final repository = ref.watch(restaurantRepositoryProvider);

      final notifier = RestaurantStateNotifier(repository: repository);

      return notifier;
    }
);

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  // repository의 데이터를 가져와야함
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }): super([]) {
    // 바로 실행
    paginate();
  }


  paginate()async {
    final response = await repository.paginate();

    state = response.data;
  }
}