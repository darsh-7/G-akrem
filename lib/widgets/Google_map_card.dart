import 'package:akrem/Screens/map/Select_location.dart';
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
      // padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      ),
      child: GestureDetector(
          onTap: () => Get.to(SelectLocation()),
          child: Stack(children: <Widget>[
            Card(
              margin: EdgeInsets.all(0),
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
                      target: user.user.getLocation() ??
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
                Divider( color: Colors.black,height: 2,),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  width: double.infinity,
                  color: Get.theme.canvasColor,
                  child: Text("Location: ${user.user.locationString}",maxLines: 1,),
                )
              ],
            )
          ])),
    );
  }
}
