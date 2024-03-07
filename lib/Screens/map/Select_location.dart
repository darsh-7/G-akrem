//AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
//import 'package:geolocator/geolocator.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/location_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/user.dart';
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
LatLng initialPoint = LatLng(29.9908511828, 31.2343635312);
LatLng mti = LatLng(29.992895885508347, 31.31135928995078);

class _SelectLocation extends State<SelectLocation> {
  LocationController googleMapController = Get.put(LocationController());
  UserController userController = Get.find();

  LatLng initialPoint = LatLng(30.0225, 31.4381);
  CameraPosition _currenCordenat = CameraPosition(
    target: LatLng(30.0225, 31.4381),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Location"),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 108),
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
          onCameraIdle: ()  {
             googleMapController.cameraChanged(_currenCordenat.target.latitude,
                _currenCordenat.target.longitude);
          },
          markers: _markers.values.toSet(),
          zoomControlsEnabled: false,
          //myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: initialPoint,
            zoom: 14,
            bearing: 30,
           // tilt: 45,
          ),
          onMapCreated: (controller)  {
            googleMapController.mapController = controller;
            //googleMapController.cameraChanged(value);
             googleMapController.cameraChanged(
                initialPoint.latitude, initialPoint.longitude);
          },
          onCameraMove: (value) {
            _currenCordenat = value;
          },
        ),
        Center(
          child: Icon(
            Icons.location_on,
            color: Get.theme.primaryColor,
            size: 40,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),

              ),

              height: 50,
              width: 50,
              child: SvgPicture.asset(AppImages.akremLogoSVG,colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),),
            )
          ],
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
                              hintText: "Loading...",
                              enabled: false,
                              readOnly: true,
                              controller: googleMapController.searchController,
                              // onChanged: (value) {},
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          child: const Text("Set Location"),
                          onPressed: () async {
                            await userController.editUser(User(
                                locationLatitude:
                                    _currenCordenat.target.latitude,
                                locationLongitude:
                                    _currenCordenat.target.longitude,
                                locationString:
                                    googleMapController.searchController.text));

                            Get.offAll(() => NavigationBarApp());
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
