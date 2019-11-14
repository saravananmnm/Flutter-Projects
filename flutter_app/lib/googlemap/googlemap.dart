import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  static String tag = 'Map';

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  static double lat = 0;
  static double long = 0;
  Completer<GoogleMapController> _controller = Completer();
  var pos;
  bool hasPermission = false;
  var location = new Location();
  var geolocator = new Geolocator();
  String _platformVersion;
  Map<String, double> currentLocation = new Map();
  Map<String, double> myLocation;
  String error;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

/*
  void MyLocation() async {
    if (hasPermission) {
      try {
        var locationOptions = LocationOptions(
            accuracy: LocationAccuracy.high, distanceFilter: 10);

        StreamSubscription<Position> positionStream = await geolocator
            .getPositionStream(locationOptions)
            .listen((Position data) {
          if (data != null) {
            lat = data.longitude;
            long = data.longitude;
            setState(() {});
          }
        });

        print(lat);
      } catch (e) {
        pos = null;
      }
    } else {}
  }
*/

  Future<bool> permssion() {
    if (location.hasPermission() != null) {
      hasPermission = true;
    } else {
      hasPermission = false;
    }
  }

  /*Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((location) {
      if (location != null) {
        print("Location: ${location.latitude},${location.longitude}");
          lat = location.latitude;
        long = location.longitude;
      }
      return location;
    });
  }
*/
  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      //target: LatLng(lat, long),
      tilt: 59.440717697143555,
      zoom: 19.0);

  @override
  void initState() {
    super.initState();
    // permssion();
    //MyLocation();
    // getUserLocation();
  }

  Future getUserLocation() async {
    //call this async method from whereever you need
    try {
      //  myLocation = await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    final coordinates = new Coordinates(
        currentLocation['latitude'], currentLocation['longitude']);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 400,
          margin: EdgeInsets.all(15.0),
          width: 400,
          child: GoogleMap(
            mapType: MapType.normal,
            padding: EdgeInsets.all(50.0),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ],
    ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
