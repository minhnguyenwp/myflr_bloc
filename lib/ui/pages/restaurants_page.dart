import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_bloc.dart';
import 'package:mflrbloc/data/blocs/restaurant_bloc.dart';

import 'package:mflrbloc/data/blocs/restaurant_events.dart';
import 'package:mflrbloc/data/blocs/restaurant_states.dart';

import 'package:mflrbloc/data/models/location.dart';

import 'package:mflrbloc/ui/pages/favorite_page.dart';
import 'package:mflrbloc/ui/pages/location_page.dart';
import 'package:mflrbloc/ui/pages/widgets/message.dart';
import 'package:mflrbloc/ui/pages/widgets/retaurants_list.dart';

class RestaurantsPage extends StatelessWidget {
  final LocationModel location;

  const RestaurantsPage({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final LocationListBloc locationListBloc = context.bloc<LocationListBloc>();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(location.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FavoritePage())),
            )
          ],
        ),
        body: _buildSearch(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit_location),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BlocProvider.value(
                  value: locationListBloc,
                  child: LocationPage( isFullScreenDialog: true,),
                );
                
              },
              fullscreenDialog: true)
          ),
        ),
      ),
    
    );
  }

  Widget _buildSearch(BuildContext context) {
    final RestaurantBloc restaurantBloc = context.bloc<RestaurantBloc>();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'What do you want to eat?'),
            onChanged: (term) {
              restaurantBloc.add(SearchTxtChangedEvent(searchTerm: term));
            }
          ),
        ),
        Expanded(
          child: _buildResult(context),
        )
      ],
    );
  }

  Widget _buildResult(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantUnInitState) {
          return Message(
              message: "Find your restaurant");
        } else if (state is RestaurantEmptyState) {
          return Message(
              message: "Restaurant not found ");
        } else if (state is RestaurantFetchingState) {
          return Center(child: CircularProgressIndicator());  
        } else {
          final restaurantsState = state as RestaurantFetchedState;
          final restaurants = restaurantsState.restaurants;

          if (restaurants.length > 0) {
            return RestaurantsList(restaurants: restaurants);
          } else {
            return Message(
              message: "Restaurant not found ");
          }
          
        }
      }
    );
  }

  // Widget _buildListRestaurants(List<RestaurantModel> results) {
  //   return ListView.separated(
  //     itemCount: results.length,
  //     separatorBuilder: (context, index) => Divider(),
  //     itemBuilder: (context, index) {
  //       final restaurant = results[index];
  //       return RestaurantTile(restaurant: restaurant);
  //     },
  //   );
  // }
}