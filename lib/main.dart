import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mflrbloc/data/blocs/favorite_bloc.dart';
import 'package:mflrbloc/data/blocs/location_list_bloc.dart';
import 'package:mflrbloc/data/services/api_provider.dart';
import 'package:mflrbloc/ui/pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<LocationListBloc>(
          create: (BuildContext context) => LocationListBloc(apiProvider: ApiProvider()),
        ),
        BlocProvider<FavoriteBloc>(
          create: (BuildContext context) => FavoriteBloc(),
        ),
      ], 
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant Finder',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MainPage(),
      ),
    );
  }
}
