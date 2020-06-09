 

import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/restaurant.dart';
import 'package:mflrbloc/ui/pages/widgets/restaurant_tile.dart';

class RestaurantsList extends StatelessWidget {
  final List<RestaurantModel> restaurants;
  
  const RestaurantsList({Key key, @required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: restaurants.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return RestaurantTile(restaurant: restaurant);
      },
    );
  }
}