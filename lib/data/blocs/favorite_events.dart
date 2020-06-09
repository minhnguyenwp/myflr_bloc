import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/restaurant.dart';


abstract class FavoriteEvent{}

// EVENT: select a Contry
class ToggleFavoriteEvent extends FavoriteEvent{
  final RestaurantModel restaurant;
  ToggleFavoriteEvent({@required this.restaurant}) : assert(restaurant!=null);
}
