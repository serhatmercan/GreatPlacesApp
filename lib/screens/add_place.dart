import 'dart:io';

import 'package:GreatPlacesApp/models/place.dart';
import 'package:GreatPlacesApp/providers/places.dart';
import 'package:GreatPlacesApp/widgets/image_imput.dart';
import 'package:GreatPlacesApp/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
    );
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    } else {
      Provider.of<Places>(context, listen: false).addPlace(_titleController.text, _pickedImage, _pickedLocation);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            elevation: 0,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
