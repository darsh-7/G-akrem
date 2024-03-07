import 'package:akrem/Api/api_key.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:fl_geocoder/fl_geocoder.dart' as fl;

import '../Screens/map/asses/asssis1.dart';

class LocationController extends GetxController {
  // Placemark _placemark ;
  late GoogleMapController mapController;
  final geocoder = fl.FlGeocoder(map);
  TextEditingController searchController = TextEditingController();



  Future<void> cameraChanged(double latitude, double longitude) async {

    
    // LatLng latLngPosition = LatLng(latitude, longitude);
    //
    //
    // searchController.text = await AssistantMethods.searchCoordinateAddress(latLngPosition);
    //

    final placemarks = await placemarkFromCoordinates(latitude, longitude);


    // var placemarks = await geocoder.findAddressesFromLocationCoordinates(
    //   location: fl.Location(latitude,longitude),
    // );
    if (placemarks.isNotEmpty) {
      print(" thoroughfare :${(placemarks[0].thoroughfare) ?? placemarks[0].name}, "
          "\n locality: ${placemarks[0].locality}}"
          "\n street: ${placemarks[0].street}"
          "\n subThoroughfare: ${placemarks[0].subThoroughfare}"
          "\n administrativeArea: ${placemarks[0].administrativeArea}"
      );
     final location = "${placemarks[0].locality}, ${placemarks[0].subThoroughfare} ${placemarks[0].thoroughfare}";
      // final location = "${placemarks[0].formattedAddress }, ${placemarks[0].locality}";

      searchController.text = location;
      update();

    } else {
      // Handle the case where no results are found (e.g., print a message)
      print("No address found for these coordinates.");
    }
  }


  Future<Placemark?> getAddress(double latitude, double longitude) async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {

      return placemarks[0];

    } else {
      print("No address found for these coordinates.");
    }
    return null;
  }

  Future<void> changePosition(double lat, double log) async {
    mapController.moveCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          lat,
          log,
        ),
        16,
      ),
    );
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
          10),
    );
    changePosition(pos.latitude, pos.longitude);
    update();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }
}