import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
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
                return Container(); // * 빈 컨테이너로 반환
              }

              return ListView.separated(itemBuilder: (_, index) {
                final item = snapshot.data![index];

                return RestaurantCard(
                      image: Image.network(
                          'http://$ip${item['thumbUrl']}', // * S3는 url을 그대로 넣음
                          fit: BoxFit.cover,
                      ),
                      name: item['name'],
                      tags: List<String>.from(item['tags']), // * List<dynamic> -> List<String>으로 변경
                      ratingsCount: item['ratingsCount'],
                      deliveryTime: item['deliveryTime'],
                      deliveryFee: item['deliveryFee'],
                      ratings: item['ratings'],
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
