import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mflrbloc/data/blocs/location_list_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_states.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import 'package:mflrbloc/data/services/api_provider.dart';
import 'package:mflrbloc/data/models/location.dart';
import 'package:mflrbloc/data/blocs/restaurant_events.dart';
import 'package:mflrbloc/data/blocs/restaurant_states.dart';


class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  LocationModel location;
  final LocationListBloc _locationListBloc;
  StreamSubscription _locationListSubscription;

  final ApiProvider apiProvider = ApiProvider();

  RestaurantBloc({@required LocationListBloc locationListBloc}) 
    : assert(locationListBloc != null), 
    _locationListBloc = locationListBloc {
      _locationListSubscription = locationListBloc.listen((state) {
        if (state is LocationSelectedState) {
          location = state.location;
          add(InitialEvent());
        }
      });
    }

  @override
  Stream<Transition<RestaurantEvent, RestaurantState>> transformEvents(
    Stream<RestaurantEvent> events,
    Stream<Transition<RestaurantEvent, RestaurantState>> Function(
      RestaurantEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  RestaurantState get initialState => RestaurantUnInitState();

   

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    final currentState = _locationListBloc.state;
    if (currentState is LocationSelectedState) {
      location = currentState.location;

      if(event is SearchTxtChangedEvent) {
        final String searchTerm = event.searchTerm;

        if (searchTerm.isEmpty || searchTerm.length < 3) {
          yield RestaurantUnInitState();
        } else {
          yield RestaurantFetchingState();
          try {
            
            final restaurants = await apiProvider.fetchRestaurants(location, searchTerm);
            //print(restaurants.length);
            if (restaurants.length != 0) {
              yield RestaurantFetchedState(restaurants: restaurants);
            } else {
              yield RestaurantEmptyState();
            }
          } catch (_) {
            yield RestaurantErrorState();
          }

        }
      } else if (event is InitialEvent) {
        yield RestaurantUnInitState();
      } else {
        yield RestaurantUnInitState();
      }
    } else {
        yield RestaurantUnInitState();
    }
    
  }

  @override
  Future<void> close() {
    _locationListSubscription?.cancel();
    return super.close();
  }
}