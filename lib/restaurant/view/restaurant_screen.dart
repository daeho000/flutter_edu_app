import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/common/dio/dio.dart';
import 'package:flutter_edu_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_edu_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';
import 'package:flutter_edu_app/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_edu_app/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<CursorPagination<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();


    dio.interceptors.add(
      CustomInterceptor(
        secureStorage: storage,
      ),
    );

    final repository =  RestaurantRepository(dio, baseUrl: '${address}/restaurant');

    return repository.paginate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<CursorPagination<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
              if(!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data!.data[index];

                    return GestureDetector(
                      onTap: () {
                        item.isDetail = true;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(
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
              );
            },
          )
        ),
      ),
    );
  }
}
