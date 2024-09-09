import 'package:code_factory_clone/common/const/colors.dart';
import 'package:flutter/cupertino.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight( // * 위젯이 최대 크기만큼 차지(세로로)
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              8
            ),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '떡볶이',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                      '전통 떡볶이의 정석!\n맛있습니다.',
                    overflow: TextOverflow.ellipsis, // * maxLines가 넘어가면 ... 처리가 됨
                    maxLines: 2,
                    style: TextStyle(
                      color: BODY_TEXT_COLOR,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                      '₩10000',
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
