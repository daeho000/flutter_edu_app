import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/const/colors.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_card_model.dart';
import 'package:flutter_edu_app/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const RestaurantCard({
    required this.restaurantModel,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantCardModel restaurantCardModel = RestaurantCardModel.fromJson(restaurantModel: restaurantModel);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: restaurantCardModel.image,
        ),
        const SizedBox(height: 16.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              restaurantCardModel.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 8.0,),
            Text(
              restaurantCardModel.tags.join(' · '),
              style: TextStyle(
                color: BODY_TEXT_COLOR,
                fontSize: 14.0
              ),
            ),
            const SizedBox(height: 8.0,),
            Row(
              children: [
                _IconText(
                  icon: Icons.star,
                  label: restaurantCardModel.ratings.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.receipt,
                  label: restaurantCardModel.ratingsCount.toString(),
                ),
                renderDot(),
                _IconText(
                  icon: Icons.timelapse_outlined,
                  label: '${restaurantCardModel.deliveryTime} 분',
                ),
                renderDot(),
                _IconText(
                  icon: Icons.monetization_on,
                  label: restaurantCardModel.deliveryFee == 0 ? '무료' : restaurantCardModel.deliveryFee.toString(),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        ' · ',
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    required this.icon,
    required this.label,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(height: 8.0,),
        Text(
            label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
