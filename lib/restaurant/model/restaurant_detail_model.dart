import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';

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

  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
    bool isDetail = false,
  }) {
    return RestaurantDetailModel(
      detail: json['detail'],
      products: json['products'].map<RestaurantProductModel>(
        (x) => RestaurantProductModel(
          id: x['id'],
          name: x['name'],
          detail: x['detail'],
          imgUrl: '$address/${x['imgUrl']}',
          price: x['price']),
      ).toList(),
      id: json['id'],
      name: json['name'],
      thumbUrl : '$address${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((element) => element.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      isDetail: isDetail,
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory RestaurantProductModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      imgUrl: json['imgUrl'],
      price: json['price'],
    );
  }
}
