import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/location.dart';

abstract class LocationListEvent{}

// EVENT: select a Contry
class LocationSelectedEvent extends LocationListEvent{
  final LocationModel location;
  LocationSelectedEvent({@required this.location}) : assert(location!=null);
}

// EVENT: On Text Changed
class SearchTextChangedEvent extends LocationListEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm}) : assert(searchTerm != null);
}
