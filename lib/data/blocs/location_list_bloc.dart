import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import 'package:mflrbloc/data/blocs/location_list_events.dart';
import 'package:mflrbloc/data/blocs/location_list_states.dart';
import 'package:mflrbloc/data/models/location.dart';

import 'package:mflrbloc/data/services/api_provider.dart';



class LocationListBloc extends Bloc<LocationListEvent, LocationListState> {
  final ApiProvider apiProvider;

  LocationListBloc({this.apiProvider}) : assert(apiProvider != null);

  @override
  Stream<Transition<LocationListEvent, LocationListState>> transformEvents(
    Stream<LocationListEvent> events,
    Stream<Transition<LocationListEvent, LocationListState>> Function(
      LocationListEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  LocationListState get initialState => LocaltionUnInitState();

  @override
  Stream<LocationListState> mapEventToState(LocationListEvent event) async* {
    
    if(event is SearchTextChangedEvent) {
      final String searchTerm = event.searchTerm;

      if (searchTerm.isEmpty || searchTerm.length < 3) {
        yield LocaltionUnInitState();
      } else {
        yield LocationFetchingState();
        try {
          
          final locations = await apiProvider.fetchLocations(event.searchTerm);
          //print(locations.length);
          if (locations.length != 0) {
            yield LocationFetchedState(locations: locations);
          } else {
            yield LocationEmptyState();
          }
        } catch (_) {
          yield LocationErrorState();
        }

      }
    }

    if(event is LocationSelectedEvent) {
      final LocationModel location = event.location;
      //print(state);
      final locationsState = state as LocationFetchedState;
      yield LocationSelectedState(location: location, locations: locationsState.locations);
    }
  }
}