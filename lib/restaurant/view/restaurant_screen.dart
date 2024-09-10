import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:code_factory_clone/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final res = await dio.get('http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken'
        }
      )
    );
    return res.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if(!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // * 빈 컨테이너로 반환
              }

              return ListView.separated(itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final jsonItem = RestaurantModel.fromJson(json: item);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => RestaurantDetailScreen(
                                id: jsonItem.id
                              ),
                          )
                        );
                      },
                      child: RestaurantCard.fromModel(model: jsonItem),
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
