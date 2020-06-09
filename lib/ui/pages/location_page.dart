import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_events.dart';
import 'package:mflrbloc/data/blocs/location_list_states.dart';

import 'package:mflrbloc/data/models/location.dart';
import 'package:mflrbloc/ui/pages/widgets/message.dart';

class LocationPage extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationPage({Key key, this.isFullScreenDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Where do you want to eat?')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(), 
                hintText: 'Enter a location'
              ),
              onChanged: (term) {
                BlocProvider.of<LocationListBloc>(context).add(SearchTextChangedEvent(searchTerm: term));
              },
            ),
          ),
          Expanded(
            child: _buildResults(context),
          )
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    return BlocBuilder<LocationListBloc, LocationListState>(
      //bloc: BlocProvider.of<LocationListBloc>(context),
      builder: (context, state) {
        if (state is LocaltionUnInitState) {
          return Message(
              message: "Find your location");
        } else if (state is LocationEmptyState) {
         return Message(
              message: "Location not found ");
        } else if (state is LocationFetchingState) {
          return Center(child: CircularProgressIndicator());  
        } else if (state is LocationSelectedState) {
          return _buildSearchResults(state.locations);
        } else {
          final locationsState = state as LocationFetchedState;
          final locations = locationsState.locations;
          return _buildSearchResults(locations);
        }
      }
    );
  }

  Widget _buildSearchResults(List<LocationModel> locations) {
    return ListView.separated(
      itemCount: locations.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        //final location = results[index];
        return ListTile(
          title: Text(locations[index].title),
          onTap: () {
            BlocProvider.of<LocationListBloc>(context).add(LocationSelectedEvent(location: locations[index]));
            
            if (isFullScreenDialog) {
              Navigator.of(context).pop();
            }
          }
        );
      },
    );
  }
}