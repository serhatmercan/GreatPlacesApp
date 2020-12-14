import 'package:GreatPlacesApp/providers/places.dart';
import 'package:GreatPlacesApp/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(AddPlace.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(child: const Text("Got No Places Yet, Start Adding Some")),
                builder: (ctx, places, ch) => places.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(backgroundImage: FileImage(places.items[i].image)),
                          title: Text(places.items[i].title),
                          onTap: null,
                        ),
                      ),
              ),
      ),
    );
  }
}
