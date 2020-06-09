import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mflrbloc/data/blocs/favorite_bloc.dart';
import 'package:mflrbloc/data/blocs/favorite_states.dart';
import 'package:mflrbloc/data/models/restaurant.dart';

import 'package:mflrbloc/ui/pages/widgets/message.dart';
import 'package:mflrbloc/ui/pages/widgets/retaurants_list.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteFetchedState) { 
            List<RestaurantModel> favorites = state.restaurants;
            if (favorites.length <= 0) {
              return  Message(message: "Favorite not found ");
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: RestaurantsList(restaurants: favorites),
              );
            }
          } else {
            return  Message(message: "Favorite not found ");
          }
        }
      )
    );
  }

 
}