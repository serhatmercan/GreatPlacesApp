import 'dart:io';

import 'package:GreatPlacesApp/helpers/db_helper.dart';
import 'package:GreatPlacesApp/helpers/location_helper.dart';
import 'package:GreatPlacesApp/models/place.dart';
import 'package:flutter/foundation.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findPlaceById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );

    final location = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    final place = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: location,
      image: pickedImage,
    );

    _items.add(place);
    notifyListeners();

    DBHelper.insert(
      "great_places",
      {
        "id": place.id,
        "title": place.title,
        "image": place.image.path,
        "latitude": place.location.latitude,
        "longitude": place.location.longitude,
        "address": place.location.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData("great_places");

    _items = data
        .map((e) => Place(
              id: e["id"],
              title: e["title"],
              location: PlaceLocation(
                latitude: e["latitude"],
                longitude: e["longitude"],
                address: e["address"],
              ),
              image: File(e["image"]),
            ))
        .toList();

    notifyListeners();
  }
}
