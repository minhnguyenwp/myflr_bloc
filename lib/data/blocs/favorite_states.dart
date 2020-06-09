import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/restaurant.dart';

abstract class FavoriteState {}

class FavoriteInitState extends FavoriteState {}

class FavoriteFetchedState extends FavoriteState {
  final List<RestaurantModel> restaurants;
  FavoriteFetchedState({@required this.restaurants});
}
