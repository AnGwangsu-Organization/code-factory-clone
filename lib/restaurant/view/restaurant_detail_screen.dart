import 'package:code_factory_clone/common/const/data.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:code_factory_clone/product/component/product_card.dart';
import 'package:code_factory_clone/product/model/product_model.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    super.key
  });

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final res = await dio.get('http://$ip/restaurant/$id',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken'
        }
      )
    );
    return res.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshop) {
            if(!snapshop.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            final item = RestaurantDetailModel.fromJson(
                json: snapshop.data!
            );
            
            return CustomScrollView(
              slivers: [
                renderTop(
                  model: item
                ),
                renderLabel(),
                renderProducts(
                  products: item.products
                )
              ],
            );
          },
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

  SliverPadding renderProducts({
    required List<ProductModel> products
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) {
                final model = products[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ProductCard.fromModel(model: model)
                );
              },
            childCount: products.length
          )
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model
}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
          model: model,
          isDetail: true,
      ),
    );
  }
}
