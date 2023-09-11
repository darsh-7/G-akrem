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