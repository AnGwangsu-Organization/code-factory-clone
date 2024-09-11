import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/common/dio/dio.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:code_factory_clone/restaurant/repository/restaurant_repository.dart';
import 'package:code_factory_clone/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final res = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();

    return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: paginateRestaurant(ref),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if(!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // * 빈 컨테이너로 반환
              }

              return ListView.separated(itemBuilder: (_, index) {
                    final pItem = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => RestaurantDetailScreen(
                                id: pItem.id
                              ),
                          )
                        );
                      },
                      child: RestaurantCard.fromModel(model: pItem),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 16);
                  },
                  itemCount: snapshot.data!.length);
            }
          )
        )
      )
    );
  }
}
