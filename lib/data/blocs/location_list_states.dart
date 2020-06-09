import 'package:flutter/material.dart';
import 'package:mflrbloc/data/models/location.dart';

abstract class LocationListState {}

class LocaltionUnInitState extends LocationListState {}

class LocationFetchingState extends LocationListState {}

class LocationFetchedState extends LocationListState {
  final List<LocationModel> locations;
  LocationFetchedState({@required this.locations});
}

class LocationErrorState extends LocationListState {}

class LocationEmptyState extends LocationListState {}

class LocationSelectedState extends LocationFetchedState {
  final LocationModel location;
  final List<LocationModel> locations;
  LocationSelectedState({@required this.location, this.locations});
}
