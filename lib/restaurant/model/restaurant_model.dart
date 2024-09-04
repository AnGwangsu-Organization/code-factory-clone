import 'package:code_factory_clone/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap
}

class RestaurantModel {
  final String id;
  final String thumbUrl;
  final String name;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;


  RestaurantModel({
    required this.id,
    required this.thumbUrl,
    required this.name,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // * factory constructor
  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
  }) {
     return RestaurantModel(
         id: json['id'],
         thumbUrl: 'http://$ip${json['thumbUrl']}',
         name: json['name'],
         tags: List<String>.from(json['tags']),
         priceRange: RestaurantPriceRange.values.firstWhere(
                 (e) => e.name == json['priceRange']
         ),
         ratings: json['ratings'],
         ratingsCount: json['ratingsCount'],
         deliveryTime: json['deliveryTime'],
         deliveryFee: json['deliveryFee']
     );
  }
}