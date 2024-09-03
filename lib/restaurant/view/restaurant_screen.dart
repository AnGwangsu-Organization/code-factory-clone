import 'package:code_factory_clone/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RestaurantCard(
            image: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              fit: BoxFit.cover,
            ),
            name: '불타는 떡볶이',
            tags: ['떡볶이','치즈','매운맛'],
            ratingCount: 100,
            deliveryTime: 15,
            deliveryFee: 2000,
            rating: 4.52,
          ),
        )
      )
    );
  }
}
