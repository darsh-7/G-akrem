//AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
//import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}
 String lat = "asd";
 String long = "asd";
String location = "location";

class MapSampleState extends State<MapSample> {
  // void getLocation() {
  //   determinePosition().then((value) {
  //       lat = '${value.latitude}';
  //       long= '${value.longitude}';
  //   });
  //
  //   setState(() {
  //   location = "$lat + $long";
  //   });
  // }
  //
  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text(
            '$location',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          ),
          SizedBox(height: 24),
          // ElevatedButton(
          //     onPressed: () => getLocation(),
          //     child: const Text("get")),
          SizedBox(height: 24),
          ElevatedButton(
              onPressed: () => {
                Navigator.of(context).pushNamed("/main")
              },              child: const Text("next")),

        ],
      ),
    );
  }

}