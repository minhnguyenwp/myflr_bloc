

import 'package:mflrbloc/data/models/location.dart';
import 'package:mflrbloc/data/models/restaurant.dart';
import 'package:mflrbloc/data/services/api_services.dart';

class ApiProvider {
  ApiServices _apiServices = ApiServices();

  // getLocations
  Future<List<LocationModel>> fetchLocations(String query) async {
    final results = await _apiServices.getRequest(
        path: 'locations', parameters: {'query': query, 'count': '10'});

    final suggestions = results['location_suggestions'];
    return suggestions
        .map<LocationModel>((json) => LocationModel.fromJson(json))
        .toList(growable: false);
  }


  Future<List<RestaurantModel>> fetchRestaurants(
    LocationModel location, String query) async {

    final results = await _apiServices.getRequest(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });

    final restaurants = results['restaurants']
        .map<RestaurantModel>((json) => RestaurantModel.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }
}
