import 'package:GreatPlacesApp/helpers/location_helper.dart';
import 'package:GreatPlacesApp/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _imageURL;

  void _showPreview(double latitude, double longitude) {
    final staticMapImageURL = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _imageURL = staticMapImageURL;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      _showPreview(location.latitude, location.longitude);
      widget.onSelectPlace(location.latitude, location.longitude);
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    } else {
      _showPreview(selectedLocation.latitude, selectedLocation.longitude);
      widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          child: _imageURL == null
              ? Text("No Location Chosen")
              : Image.network(
                  _imageURL,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text("Select on Map"),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
