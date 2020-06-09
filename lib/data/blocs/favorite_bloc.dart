import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mflrbloc/data/blocs/favorite_events.dart';
import 'package:mflrbloc/data/blocs/favorite_states.dart';
import 'package:mflrbloc/data/models/restaurant.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  var _restaurants = <RestaurantModel>[];

  @override
  FavoriteState get initialState {
    if (_restaurants.length <= 0) {
      return FavoriteInitState();
    } else {
      return FavoriteFetchedState(restaurants: _restaurants);
    }
  }

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    
    if(event is ToggleFavoriteEvent) {
      RestaurantModel restaurant = event.restaurant;
      if (_restaurants.contains(restaurant)) {
        _restaurants.remove(restaurant);
      } else {
        _restaurants.add(restaurant);
      }
    }

    yield FavoriteFetchedState(restaurants: _restaurants);

  }

  @override
  Future<void> close() {
    return super.close();
  }
}