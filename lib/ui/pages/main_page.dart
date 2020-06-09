import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:mflrbloc/data/blocs/favorite_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_states.dart';
import 'package:mflrbloc/data/blocs/restaurant_bloc.dart';
//import 'package:mflrbloc/data/services/api_provider.dart';
// MODELS
import 'package:mflrbloc/data/models/location.dart';
// Pages Widgets
import 'package:mflrbloc/ui/pages/location_page.dart';
import 'package:mflrbloc/ui/pages/restaurants_page.dart';


class MainPage extends StatelessWidget {
  //ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
  
    return  BlocBuilder<LocationListBloc, LocationListState>(
        builder: (context, state) {
           if (state is LocationSelectedState) {
            final LocationModel location = state.location;

            return MultiBlocProvider(
              providers: [
                BlocProvider<RestaurantBloc>(
                  create: (BuildContext context) => RestaurantBloc(locationListBloc: BlocProvider.of<LocationListBloc>(context)),
                ),
              ],
              child: RestaurantsPage(location: location),
            );
            // BlocProvider<RestaurantBloc>(
            //   create: (BuildContext context) => RestaurantBloc(locationListBloc: BlocProvider.of<LocationListBloc>(context)),
            //   child: RestaurantsPage(location: location),
            // );
            
          } else {
            return  LocationPage();
          }
        }
      
    );
    
   

  }
}