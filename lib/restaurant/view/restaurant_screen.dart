import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:code_factory_clone/restaurant/provider/restaurant_provider.dart';
import 'package:code_factory_clone/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if(data.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(itemBuilder: (_, index) {
        final pItem = data[index];

        return GestureDetector( // card와 같은 섹션을 클릭했을때 Gesture가 발생하는 widget
        onTap: () {
          Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(
                    id: pItem.id
                  )));
              },
              child: RestaurantCard.fromModel(model: pItem),
            );
          },
          separatorBuilder: (_, index) {
          return const SizedBox(height: 16);
        },
        itemCount: data.length
      )
    );
  }
}
