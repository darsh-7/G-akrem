//AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
//import 'package:geolocator/geolocator.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/location_controller.dart';
import 'package:akrem/controller/controller_mang.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/user.dart';
import 'package:akrem/widgets/input.dart';
import 'package:custom_info_window/custom_info_window.dart';
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

LatLng initialPoint = LatLng(29.9908511828, 31.2343635312);
LatLng mti = LatLng(29.992895885508347, 31.31135928995078);

class _BranchMap extends State<BranchMap> {
  LocationController googleMapController = Get.put(LocationController());
  UserController userController = Get.find();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  //Set<Marker> _markers = {};
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akrem Map", style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 110),
        child: FloatingActionButton(
          onPressed: () => googleMapController.determinePosition(),
          child: Icon(
            Icons.gps_fixed,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: Stack(children: <Widget>[
          GoogleMap(
            markers: _markers.values.toSet(),
            zoomControlsEnabled: false,
            //myLocationButtonEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: userController.user.getLocation() ?? initialPoint,
              zoom: 14,
            ),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },

            onMapCreated: (controller) {
              googleMapController.mapController = controller;
              addMarker("mti", mti, "mti");
              addMarker("initialPoint", initialPoint, "place");
              //googleMapController.cameraChanged(value);
              googleMapController.cameraChanged(
                  initialPoint.latitude, initialPoint.longitude);
              _customInfoWindowController.googleMapController = controller;
            },
            onCameraMove: (value) {
              print("Camera Move: ${value.zoom} , ${value.target}");
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 75,
            width: 150,
            offset: 50,
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
          )
          // const Center(
          //   heightFactor: 30,
          //   child: CircularProgressIndicator(),
          // ),
        ]),
      ),
    );
  }

  addMarker(String id, LatLng location, String name) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 10)), "assets/black_ios.png");
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      //icon: markerIcon,
      //infoWindow: InfoWindow(title: "MTI", snippet: "MTI"),
      onTap: () {
        _customInfoWindowController.addInfoWindow!(
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Container(
              //   width: 40,
              //   height: 40,
              //   color: Colors.blue,
              //   child: IconButton(
              //     onPressed: (){},
              //     icon: Icon(Icons.import_contacts_sharp),
              //   ),
              // )

              // Triangle.isosceles(
              //   edge: Edge.BOTTOM,
              //   child: Container(
              //     color: Colors.blue,
              //     width: 20.0,
              //     height: 10.0,
              //   ),
              // ),
            ],
          ),
          location,
        );
      },
      //icon: markerIcon,
    );

    _markers[id] = marker;
    //setState(() {});
  }
}
