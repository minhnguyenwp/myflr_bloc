import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/restaurant.dart';
import 'package:mflrbloc/ui/pages/restaurant_detail_page.dart';
import 'package:mflrbloc/ui/pages/widgets/image_container.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
   
    return ListTile(
      leading: ImageContainer(width: 50, height: 50, url: restaurant.thumbUrl),
      title: Text(restaurant.name),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                RestaurantDetailsPage(restaurant: restaurant),
          ),
        );
      },
    );
  }
}