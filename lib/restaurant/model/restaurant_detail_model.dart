import 'package:code_factory_clone/common/utils/url_utils.dart';
import 'package:code_factory_clone/product/model/product_model.dart';
import 'package:code_factory_clone/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel{
  final String detail;
  final List<ProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.thumbUrl,
    required super.name,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) => _$RestaurantDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);
}