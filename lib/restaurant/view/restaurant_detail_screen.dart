import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/common/layout/default_layout.dart';
import 'package:flutter_edu_app/product/component/product_card.dart';
import 'package:flutter_edu_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_card_model.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const RestaurantDetailScreen({
    required this.restaurantModel,
    Key? key,
  }) : super(key : key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final result = await dio.get('$address/restaurant/${restaurantModel.id}',
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken'
          },
        ),
    );
    return result.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<Map<String, dynamic>> (
        builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final result = RestaurantDetailModel.fromJson(json: snapshot.data!, isDetail: true);
          return CustomScrollView(
            slivers: [
              renderTop(
                model: result,
              ),
              renderLabel(),
              renderProduct(products: result.products),
            ],
          );
        },
        future: getRestaurantDetail(),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
}) {
    return SliverToBoxAdapter(
      child: RestaurantCard(restaurantModel: model),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  renderProduct({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) {
              final model = products[index];

              return Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                  child: ProductCard.fromModel(model: model)
              );
            },
          childCount: products.length,
        ),
      ),
    );
  }
}

