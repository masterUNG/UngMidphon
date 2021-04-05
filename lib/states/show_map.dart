import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(13.673889984344294, 100.60673480355138),
              zoom: 16,
            ),
            onMapCreated: (controller) {},mapType: MapType.satellite,
          ),buildIBackButton(context),
        ],
      )),
    );
  }

  IconButton buildIBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }
}
