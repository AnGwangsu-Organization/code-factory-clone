import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:code_factory_clone/product/component/product_card.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    super.key
  });

  Future<Object> detailRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final res = await dio.get('http://$ip/restaurant/$id',
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
        title: '불타는 떡볶이',
        child: CustomScrollView(
          slivers: [
            renderTop(),
            renderLabel(),
            renderProducts()
          ],
        )
    );
  }


  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
            '메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              (context,index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ProductCard(),
                );
              },
            childCount: 10
          )
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset(
            'asset/img/food/ddeok_bok_gi.jpg'
        ),
        name: '불타는 떡볶이',
        tags: ['떡볶이', '맛있음', '치즈'],
        ratingsCount: 100,
        deliveryTime: 30,
        deliveryFee: 3000,
        ratings: 4.76,
        isDetail: true,
        detail: '맛있는 떡볶이',
      ),
    );
  }
}
