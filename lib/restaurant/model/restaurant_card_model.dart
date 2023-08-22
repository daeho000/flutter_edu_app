import 'package:flutter/material.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';

class RestaurantCardModel {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;
  final bool isDetail;
  late String? detail;

  RestaurantCardModel({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    required this.isDetail,
    this.detail,
  });

  factory RestaurantCardModel.fromJson({
    required RestaurantModel restaurantModel,
    String? detail,
  }) {
    return RestaurantCardModel(
      image : Image.network(
        restaurantModel.thumbUrl,
        fit: BoxFit.cover,
      ),
      name : restaurantModel.name,
      tags : restaurantModel.tags,
      ratingsCount : restaurantModel.ratingsCount,
      deliveryTime : restaurantModel.deliveryTime,
      deliveryFee : restaurantModel.deliveryFee,
      ratings : restaurantModel.ratings,
      isDetail : restaurantModel.isDetail,
      detail: detail,
    );
  }
}
