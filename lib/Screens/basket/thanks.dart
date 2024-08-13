
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'edit_donation.dart';

class ThanksScreen extends StatelessWidget {
  ThanksScreen({super.key});

  BasketController controller = Get.find();

  //Uint8List pic = Get.arguments["picFile"];
  final _formKey = GlobalKey<FormState>();
  final _buildingController = TextEditingController();
  final _streetController = TextEditingController();

  final _apartmentController = TextEditingController();
  final _floorController = TextEditingController();
  final _phoneController = TextEditingController();
  var hasWhatsApp = false.obs;

  Duration minExDate = const Duration(days: 3 * 7);
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Get.theme.primaryColor,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),

        //extendBodyBehindAppBar: true,

        body: ListView(children: [
          Padding(padding: EdgeInsets.only(top: statusBarHeight), child: null),
          Padding(
            padding: EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(AppImages.thanks, fit: BoxFit.fitWidth),
              ),
            ),
          ),
          Center(
            child: Text(
              'Thank You for the donation ❤️',
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.offAll(NavigationBarApp());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFadffd3),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          elevation: 20,
                                          shadowColor: Colors.transparent,
                                          minimumSize:
                                              const Size.fromHeight(48),
                                        ),
                                        child: Text("Home",
                                            style: TextStyle(
                                                color: Colors.black))))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ElevatedButton(
                                        onPressed: () => {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF8bd5ff),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          elevation: 20,
                                          shadowColor: Colors.transparent,
                                          minimumSize:
                                              const Size.fromHeight(48),
                                        ),
                                        child: Text(
                                          "Share",
                                          style: TextStyle(color: Colors.black),
                                        )))),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () => {Get.to(EditDonation())},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFbedaff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 20,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size.fromHeight(48),
                            ),
                            child: Text("Details",
                                style: TextStyle(color: Colors.black))))
                  ],
                ),
              ))
        ]));
  }
}
