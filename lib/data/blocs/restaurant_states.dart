import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/restaurant.dart';

abstract class RestaurantState {}

class RestaurantUnInitState extends RestaurantState {}

class RestaurantFetchingState extends RestaurantState {}

class RestaurantFetchedState extends RestaurantState {
  final List<RestaurantModel> restaurants;
  RestaurantFetchedState({@required this.restaurants});
}

class RestaurantErrorState extends RestaurantState {}

class RestaurantEmptyState extends RestaurantState {}

// class RestaurantSelectedState extends RestaurantState {
//   final RestaurantModel restaurant;
//   RestaurantSelectedState({@required this.restaurant});
// }
