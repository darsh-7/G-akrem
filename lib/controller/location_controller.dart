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
  late GoogleMapController mapController;
  final geocoder = fl.FlGeocoder(map);
  TextEditingController searshController = TextEditingController();

  Future<void> cameraChanged(double latitude, double longitude) async {
    // List<Placemark> placemarks = await placemarkFromCoordinates(poss.target.latitude, poss.target.longitude);
    // Placemark place1 = placemarks[0];
    // Placemark place2 = placemarks[1];
    // // String _currentAddress =
    // //     "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
    // searshController.text =
    //     "${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}";
    // print("${place1.name} ${place2.name} ${place1.subLocality} ${place1.subAdministrativeArea} ${place1.postalCode}");

    placemarkFromCoordinates(latitude, longitude).then((placemarks) async {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output = placemarks[0].toString();
      }
      //mapController.moveCamera(CameraUpdate.newLatLngZoom(poss.target, 14));
    });
    final results = await geocoder.findAddressesFromLocationCoordinates(
      location: fl.Location(latitude, longitude),
      useDefaultResultTypeFilter: true,
      // resultType: 'route', // Optional. For custom filtering.
    );
    // ${results[0].country?.shortName?.toUpperCase()},
    // String location = "";
    // for(int i =0 ; i <= results[0].addressComponents.length;i++){
    //   location = "${location},${results[0].addressComponents[i].shortName}";
    // }
    //${results[0].addressComponents[3].shortName},
    final location =
        "${results[0].addressComponents[2].shortName}, ${results[0].formattedStreet}";
    searshController.text = location;
    update();
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
    late bool serviceEnabled;
    LocationPermission permission;

// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('', 'Location Permission Denied');
        return Future.error('Location permissions are denied');
      }
    }


    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var pos = await Geolocator.getCurrentPosition();
    await mapController.moveCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(
            pos.latitude,
            pos.longitude,
          ),
          18),
    );
    changePosition(pos.latitude, pos.longitude);
    update();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }
}
