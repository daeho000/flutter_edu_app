import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/common/dio/dio.dart';
import 'package:flutter_edu_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_edu_app/common/secure_storage/secure_storage.dart';
import 'package:flutter_edu_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_edu_app/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_edu_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_edu_app/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final cp = data as CursorPagination;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: cp.data.length,
          itemBuilder: (_, index) {
            final item = cp.data[index];

            return GestureDetector(
                onTap: () {
                  item.isDetail = true;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          RestaurantDetailScreen(
                            restaurantModel: item,
                          ),
                    ),
                  );
                },
                child: RestaurantCard(restaurantModel: item)
            );
          },
          separatorBuilder: (_, index) {
            return const SizedBox(height: 16.0);
          },
        ),
    );
  }
}
