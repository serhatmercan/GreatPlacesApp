import 'package:GreatPlacesApp/providers/places.dart';
import 'package:GreatPlacesApp/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<Places>(context, listen: false).findPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  initialLocation: place.location,
                  isSelecting: false,
                ),
              ),
            ),
            child: Text("View on Map"),
          ),
        ],
      ),
    );
  }
}
