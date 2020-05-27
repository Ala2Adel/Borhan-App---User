
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:Borhan_User/helper/location_helper.dart';
import '../screens/location_map_screen.dart';

class LocationSelectionInput extends StatefulWidget {
  @override
  _LocationSelectionInputState createState() => _LocationSelectionInputState();
}

class _LocationSelectionInputState extends State<LocationSelectionInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
   final LatLng selectedLocation = await  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MapScreen(
                isSelecting: true,
              )),
    );
    if(selectedLocation == null){
      return;
    }
    //..
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            height: 175,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            width: double.infinity,
            child: _previewImageUrl == null
                ? Text(
                    'لم يتم اختيار موقعك جغرافيا بعد',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('الموقع الحالي'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('حدد موقعك'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
