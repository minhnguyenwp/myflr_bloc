import 'package:flutter/material.dart';

abstract class RestaurantEvent{}
class InitialEvent extends RestaurantEvent {}

// EVENT: On Text Changed
class SearchTxtChangedEvent extends RestaurantEvent {
  final String searchTerm;

  SearchTxtChangedEvent({@required this.searchTerm}) : assert(searchTerm != null);
}
