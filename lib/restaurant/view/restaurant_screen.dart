import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/restaurant/component/restaurant_card.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final result = await dio.get('$address/restaurant'
    ,options: Options(
          headers: {
            'authorization': 'Bearer $accessToken'
          }
        )
    );
    await storage.write(key: ACCESS_TOKEN_KEY, value: result.data['accessToken']);
    return result.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if(!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final item = snapshot.data![index];
                    final pItem = RestaurantModel.fromJson(json: item,);

                    return RestaurantCard(restaurantModel: pItem);
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
