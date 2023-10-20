import 'package:akrem/Screens/map/map_screen.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapCard extends StatelessWidget {
  GoogleMapCard({super.key});

  UserController user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     blurRadius: 5,
        //     offset: const Offset(0, -9), // Shadow position
        //   ),
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     blurRadius: 1,
        //     offset: const Offset(0, -9), // Shadow position
        //   ),
        // ],
      ),
      child: GestureDetector(
          onTap: () => Get.to(SelectLocation()),
          child: Stack(children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0)),
                  child: GoogleMap(
                    liteModeEnabled: true,
                    mapToolbarEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: user.user.location ??
                          LatLng(29.992895885508347, 31.31135928995078),
                      zoom: 18,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.location_on,
                color: Get.theme.primaryColor,
                size: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  color: Get.theme.canvasColor,
                  child: Text("Location: ${user.user.locationString}"),
                )
              ],
            )
          ])),
    );
  }
}
