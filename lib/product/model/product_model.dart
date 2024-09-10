import 'package:code_factory_clone/common/utils/url_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: UrlUtils.pathToUrl
  )
  final String imgUrl;
  final String detail;
  final int price;


  ProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price
  });
  
  factory ProductModel.fromJson(Map<String, dynamic> json)
  => _$ProductModelFromJson(json);
}