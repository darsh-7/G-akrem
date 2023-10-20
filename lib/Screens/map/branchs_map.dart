//AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
//import 'package:geolocator/geolocator.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/location_controller.dart';
import 'package:akrem/controller/controller_mang.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/user.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../Api/api_key.dart';

class BranchMap extends StatefulWidget {
  const BranchMap({super.key});

  @override
  State<BranchMap> createState() => _BranchMap();
}

Map<String, Marker> _markers = {};
LatLng initialPoint = LatLng(29.9908511828, 31.2343635312);
LatLng mti = LatLng(29.992895885508347, 31.31135928995078);

class _BranchMap extends State<BranchMap> {
  LocationController googleMapController = Get.put(LocationController());
  UserController userController = Get.find();

  LatLng initialPoint = LatLng(29.992895885508347, 31.31135928995078);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akrem Map"),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () => googleMapController.determinePosition(),
          child: Icon(
            Icons.gps_fixed,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(

          markers: _markers.values.toSet(),
          zoomControlsEnabled: false,
          //myLocationButtonEnabled: true,
          //myLocationEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: initialPoint,
            zoom: 14,
          ),
          onMapCreated: (controller) {
            googleMapController.mapController = controller;
            addMarker("mti", mti);
            addMarker("mti", initialPoint);
            //googleMapController.cameraChanged(value);
            googleMapController.cameraChanged(
                initialPoint.latitude, initialPoint.longitude);
          },
          onCameraMove: (value) {
            print("Camere Move: ${value.zoom} , ${value.target}");
          },
        ),
        // const Center(
        //   heightFactor: 30,
        //   child: CircularProgressIndicator(),
        // ),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Get.theme.scaffoldBackgroundColor.withAlpha(1000),
              padding: EdgeInsets.all(8),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  addMarker(String id, LatLng location) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), AppImages.mvrk);
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(title: "MTI", snippet: "MTI"),
      //icon: markerIcon,
    );

    _markers[id] = marker;
    setState(() {});
  }

}
