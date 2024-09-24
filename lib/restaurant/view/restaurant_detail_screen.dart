import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:code_factory_clone/product/component/product_card.dart';
import 'package:code_factory_clone/product/model/product_model.dart';
import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_detail_model.dart';
import 'package:code_factory_clone/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<RestaurantDetailModel>(
          future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
          builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshop) {
            if(!snapshop.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomScrollView(
              slivers: [
                renderTop(
                  model: snapshop.data!
                ),
                renderLabel(),
                renderProducts(
                  products: snapshop.data!.products
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
