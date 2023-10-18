//AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
//import 'package:geolocator/geolocator.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/location_controller.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../Api/api_key.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocation();
}

Map<String, Marker> _markers = {};

class _SelectLocation extends State<SelectLocation> {
  LocationController googleMapController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Location"),
      ),
      floatingActionButton:
      Padding(
        padding: EdgeInsets.only(bottom: 108),
        child:       FloatingActionButton(
          onPressed: ()=> googleMapController.determinePosition(),
          child: Icon(Icons.gps_fixed,color: Colors.white,),
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
            target: LatLng(29.992895885508347, 31.31135928995078),
            zoom: 14,
          ),
          onMapCreated: (controller) {
            googleMapController.mapController = controller;
            addMarker("mti", LatLng(29.992895885508347, 31.31135928995078));
          },
          onCameraMove: (value) {
            googleMapController.cameraChanged(value);
            print("Camere Move: ${value.zoom} , ${value.target}");
            // setState(() {
            //   zoomCamera = value.zoom;
            //   latLngCamera = value.target;
            // });
          },
        ),
        Center(
          child: Icon(Icons.location_on,color: Get.theme.primaryColor,size: 40,),
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
                      // CustomInputField(
                      //   focusedRadius: 0,
                      //   hintText: "Expiration date",
                      //   //controller: _dateController,
                      //   //label: "Expiration date",
                      //   readOnly: true,
                      //   icon: Icon(
                      //     Icons.location_on,
                      //     color: Get.theme.primaryColor,
                      //     size: 30,
                      //   ),
                      // ),
                      Container(
                        //color: Get.theme.primaryColor,
                        padding: EdgeInsets.all(0),
                        //margin: EdgeInsets.only(left: 20, right: 20, top: 8),
                        height: 50,
                        child: Center(
                          child: Container(
                            //margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              //color: Get.theme.primaryColor
                            ),
                            child: CustomInputField(
                              controller: googleMapController.searshController,

                              onChanged: (value){

                              },
                            ),
                          ),
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

  // placesAutoCompleteTextField() {
  //   return Container(
  //     //padding: EdgeInsets.symmetric(horizontal: 20),
  //     child: GooglePlaceAutoCompleteTextField(
  //       textEditingController: googleMapController.searshController,
  //
  //       googleAPIKey: map,
  //       inputDecoration: InputDecoration(
  //         hintText: "Search your location",
  //         border: InputBorder.none,
  //         enabledBorder: InputBorder.none,
  //         fillColor: Colors.red,
  //       ),
  //       debounceTime: 400,
  //       countries: ["eg"],
  //       isLatLngRequired: false,
  //       getPlaceDetailWithLatLng: (Prediction prediction) {
  //         print("placeDetails" + prediction.lat.toString());
  //       },
  //
  //       itemClick: (Prediction prediction) {
  //         googleMapController.searshController.text =
  //             prediction.description ?? "";
  //         googleMapController.searshController.selection =
  //             TextSelection.fromPosition(
  //                 TextPosition(offset: prediction.description?.length ?? 0));
  //
  //         //googleMapController.changePosition(double.parse(prediction.??""),double.parse(prediction.lng??""));
  //         //mapController = prediction.placeId;
  //       },
  //       seperatedBuilder: Divider(),
  //       // OPTIONAL// If you want to customize list view item builder
  //       itemBuilder: (context, index, Prediction prediction) {
  //         return Container(
  //           padding: EdgeInsets.all(10),
  //           child: Row(
  //             children: [
  //               Icon(Icons.location_on),
  //               SizedBox(
  //                 width: 7,
  //               ),
  //               Expanded(child: Text("${prediction.description ?? ""}"))
  //             ],
  //           ),
  //         );
  //       },
  //
  //       isCrossBtnShown: true,
  //
  //       // default 600 ms ,
  //     ),
  //   );
  // }
}
