import 'package:akrem/Api/api_key.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:fl_geocoder/fl_geocoder.dart' as fl;

class LocationController extends GetxController {
  // Placemark _placemark ;
  late GoogleMapController mapController;
  final geocoder = fl.FlGeocoder(map);
  TextEditingController searshController = TextEditingController();

  Future<void> cameraChanged(CameraPosition poss) async {
    // List<Placemark> placemarks = await placemarkFromCoordinates(poss.target.latitude, poss.target.longitude);
    // Placemark place1 = placemarks[0];
    // Placemark place2 = placemarks[1];
    // // String _currentAddress =
    // //     "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
    // searshController.text =
    //     "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
    // print("${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}");

    placemarkFromCoordinates(poss.target.latitude, poss.target.longitude)
        .then((placemarks) async {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output = placemarks[0].toString();
      }
      //mapController.moveCamera(CameraUpdate.newLatLngZoom(poss.target, 14));
      final results = await geocoder.findAddressesFromLocationCoordinates(
        location: fl.Location(poss.target.latitude, poss.target.longitude),
        useDefaultResultTypeFilter: true,
        // resultType: 'route', // Optional. For custom filtering.
      );
      // ${results[0].country?.shortName?.toUpperCase()},
      // String location = "";
      // for(int i =0 ; i <= results[0].addressComponents.length;i++){
      //   location = "${location},${results[0].addressComponents[i].shortName}";
      // }

      final location =
          "${results[0].addressComponents[3].shortName}, ${results[0].addressComponents[2].shortName}, ${results[0].formattedStreet}";
      searshController.text = location;
      update();
    });
  }

  Future<void> changePositionn(double lat, double log) async {
    mapController.moveCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(
            lat,
            log,
          ),
          16),
    );
    update();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

  Future<void> changePosition(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      searshController.text =
          "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var pos = await Geolocator.getCurrentPosition();
    mapController.moveCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(
            pos.latitude,
            pos.longitude,
          ),
          16),
    );
    changePosition(pos.latitude,pos.longitude);
    update();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }
}
