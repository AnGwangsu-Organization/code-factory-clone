import 'package:code_factory_clone/common/const/colors.dart';
import 'package:code_factory_clone/product/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,

    super.key
  });


  factory ProductCard.fromModel({
    required ProductModel model,
}) {
    return ProductCard(
        image: Image.network(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        name: model.name,
        detail: model.detail,
        price: model.price
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight( // * 위젯이 최대 크기만큼 차지(세로로)
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              8
            ),
            child: image,
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                      detail,
                    overflow: TextOverflow.ellipsis, // * maxLines가 넘어가면 ... 처리가 됨
                    maxLines: 2,
                    style: TextStyle(
                      color: BODY_TEXT_COLOR,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                      '₩$price',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12,
                      fontWeight: FontWeight.w600
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
