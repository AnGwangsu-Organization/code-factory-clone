import 'package:code_factory_clone/common/const/colors.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  // * 이미지
  final Widget image;
  // * 레스토링 이미지
  final String name;
  // * 레스토랑 태그
  final List<String> tags;
  // * 별점 수
  final int ratingsCount;
  // * 배달 시간
  final int deliveryTime;
  // * 배달비
  final int deliveryFee;
  // * 별점
  final double ratings;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,

    super.key
  });

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
}) {
    return RestaurantCard(
        image: Image.network(
          model.thumbUrl, // * S3는 url을 그대로 넣음
          fit: BoxFit.cover,
        ),
        name: model.name,
        tags: model.tags, // * List<dynamic> -> List<String>으로 변경
        ratingsCount: model.ratingsCount,
        deliveryTime: model.deliveryTime,
        deliveryFee: model.deliveryFee,
        ratings: model.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // * 테두리를 깍는다
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
            ),
            const SizedBox(height: 8),
            Text(
              tags.join(' · '),
              style: const TextStyle(
                color: BODY_TEXT_COLOR,
                fontSize: 14
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _IconText(
                  icon: Icons.star,
                  label: ratings.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.receipt,
                  label: ratingsCount.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.timelapse_outlined,
                  label: '$deliveryTime분',
                ),
                renderDot(),
                _IconText(
                  icon: Icons.monetization_on,
                  label: deliveryFee == 0  ? '무료' : deliveryFee.toString(),
                ),
              ],
            )
          ],
        )
      ],
    );
  }


  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ' · ',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}


class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    required this.icon,
    required this.label,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}
