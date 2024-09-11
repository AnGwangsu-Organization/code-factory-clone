import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/common/dio/dio.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:code_factory_clone/restaurant/repository/restaurant_repository.dart';
import 'package:code_factory_clone/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(storage: storage)
    );

    final res = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();

    return res.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: paginateRestaurant(),
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
