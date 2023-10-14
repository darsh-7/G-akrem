//AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
//import 'package:geolocator/geolocator.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocation();
}

Map<String, Marker> _markers = {};

class _SelectLocation extends State<SelectLocation> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Location"),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          markers: _markers.values.toSet(),
          initialCameraPosition: CameraPosition(
            target: LatLng(29.992895885508347, 31.31135928995078),
            zoom: 14,
          ),
          onMapCreated: (controller) {
            mapController = controller;
            addMarker("mti", LatLng(29.992895885508347, 31.31135928995078));
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Get.theme.scaffoldBackgroundColor,
              padding: EdgeInsets.all(8),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      CustomInputField(
                        focusedRadius: 0,
                        hintText: "Expiration date",
                        //controller: _dateController,
                        //label: "Expiration date",
                        readOnly: true,
                        icon: Icon(
                          Icons.location_on,
                          color: Get.theme.primaryColor,
                          size: 30,
                        ),
                      ),
                      ElevatedButton(
                          child: const Text("Set Location"),
                          onPressed: () async {
                            Get.offAll(NavigationBarApp());
                          }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),

      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //
      //   children: [
      //     Text(
      //       '$location',
      //       style: Theme
      //           .of(context)
      //           .textTheme
      //           .headlineMedium,
      //     ),
      //     SizedBox(height: 24),
      //     // ElevatedButton(
      //     //     onPressed: () => getLocation(),
      //     //     child: const Text("get")),
      //     SizedBox(height: 24),
      //     ElevatedButton(
      //         onPressed: () => {
      //           Get.offAll(NavigationBarApp()),
      //         },              child: const Text("next")),
      //
      //   ],
      // ),
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
