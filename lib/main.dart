import 'package:GreatPlacesApp/providers/places.dart';
import 'package:GreatPlacesApp/screens/add_place.dart';
import 'package:GreatPlacesApp/screens/place_detail.dart';
import 'package:GreatPlacesApp/screens/place_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Great Places",
        theme: ThemeData(
          accentColor: Colors.amber,
          primarySwatch: Colors.indigo,
        ),
        home: PlaceList(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
          PlaceDetail.routeName: (ctx) => PlaceDetail(),
        },
      ),
    );
  }
}
