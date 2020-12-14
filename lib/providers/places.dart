import 'dart:io';

import 'package:GreatPlacesApp/helpers/db_helper.dart';
import 'package:GreatPlacesApp/models/place.dart';
import 'package:flutter/foundation.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final place = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
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
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData("great_places");

    _items = data
        .map((e) => Place(
              id: e["id"],
              title: e["title"],
              location: null,
              image: File(e["image"]),
            ))
        .toList();

    notifyListeners();
  }
}
