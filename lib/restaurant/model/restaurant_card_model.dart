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

  RestaurantCardModel({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  });

  factory RestaurantCardModel.fromJson({
    required RestaurantModel restaurantModel,
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
    );
  }
}
