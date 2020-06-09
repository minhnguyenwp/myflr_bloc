import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mflrbloc/data/blocs/favorite_bloc.dart';
import 'package:mflrbloc/data/blocs/favorite_events.dart';
import 'package:mflrbloc/data/blocs/favorite_states.dart';
import 'package:mflrbloc/data/models/restaurant.dart';
import 'package:mflrbloc/ui/pages/widgets/image_container.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailsPage({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant.cuisines,
                  style: textTheme.subtitle2.copyWith(fontSize: 18),
                ),
                Text(
                  restaurant.address,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavoriteButton(context)
        ],
      ),      
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 200,
      url: restaurant.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price: ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(width: 40),
          Text(
            'Rating: ${restaurant.rating.average}',
            style: style,
          ),
        ],
      ),
    );
  }

  // 1
  Widget _buildFavoriteButton(BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
      
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        
        var isFavorite = false;
        if (state is FavoriteFetchedState) { 
          List<RestaurantModel> favorites = state.restaurants;
          isFavorite = favorites.contains(restaurant);
          
        }
        return FlatButton.icon(
          onPressed: () => favoriteBloc.add(ToggleFavoriteEvent(restaurant: restaurant)),
          textColor: isFavorite ? Theme.of(context).accentColor : null,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text('Favorite'),
        );
      }
    );
        
  }
}