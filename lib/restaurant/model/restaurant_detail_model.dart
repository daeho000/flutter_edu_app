import 'package:flutter_edu_app/common/utils/data_utils.dart';
import 'package:flutter_edu_app/product/model/restaurant_product_model.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String? detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required this.detail,
    required this.products,
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    super.isDetail = false,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json)
  => _$RestaurantDetailModelFromJson(json);
}
