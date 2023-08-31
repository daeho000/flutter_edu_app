import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/common/dio/dio.dart';
import 'package:flutter_edu_app/common/layout/default_layout.dart';
import 'package:flutter_edu_app/common/secure_storage/secure_storage.dart';
import 'package:flutter_edu_app/product/component/product_card.dart';
import 'package:flutter_edu_app/product/model/restaurant_product_model.dart';
import 'package:flutter_edu_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_edu_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final RestaurantModel restaurantModel;

  const RestaurantDetailScreen({
    required this.restaurantModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: restaurantModel.name,
      child: FutureBuilder<RestaurantDetailModel>(
        builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          snapshot.data!.isDetail = true;
          return CustomScrollView(
            slivers: [
              renderTop(
                model: snapshot.data!,
              ),
              renderLabel(),
              renderProduct(products: snapshot.data!.products),
            ],
          );
        },
        future: ref.watch(restaurantRepositoryProvider).getRestaurantDetail(
              id: restaurantModel.id,
            ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        restaurantModel: model,
        detail: model.detail,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
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
                child: ProductCard.fromModel(model: model));
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
