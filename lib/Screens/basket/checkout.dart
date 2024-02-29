import 'dart:io';

import 'package:akrem/Screens/basket/thanks.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:akrem/controller/location_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/widgets/Google_map_card.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/model/medic.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/log_manager.dart';
import '../../services/validator.dart';

class Checkout extends StatelessWidget {
  Checkout({super.key});



  UserController userController = Get.find();
  LocationController googleMapController = Get.put(LocationController());

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
        appBar: _buildAppBar(),
        //extendBodyBehindAppBar: true,
        body: ListView(children: [
          Padding(padding: EdgeInsets.only(top: statusBarHeight), child: null),
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Colors.transparent,
            ),
            child: Container(
              margin: EdgeInsets.all(20),
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 5), // Shadow position
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 1,
                    offset: const Offset(0, -1), // Shadow position
                  ),
                ],
                color: Colors.transparent,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  child: GoogleMapCard(),
                ),
              ),
            ),
          ),
          GetBuilder<LocationController>(
              init: googleMapController,
              initState: (_) async {

                final address = await googleMapController.getAddress(userController.user.locationLatitude ?? 0, userController.user.locationLatitude ?? 0);
                _streetController.text = address?.street ?? "";
                _phoneController.text = userController.user.phone ?? "";
              },
              builder: (_) {
            return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(height: 16),
                      CustomInputField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Building",
                        controller: _buildingController,
                        validator: Validator.validateEmpty,
                        label: "Building",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        hintText: "Street",
                        controller: _streetController,
                        validator: Validator.validateEmpty,
                        label: "Street ",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(360),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        hintText: "Apartment",
                        controller: _apartmentController,
                        validator: Validator.validateEmpty,
                        label: "Apartment",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(360),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomInputField(
                        hintText: "Floor",
                        controller: _floorController,
                        validator: Validator.validateEmail,
                        label: "Floor ",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(360),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomInputField(
                              keyboardType: TextInputType.number,
                              hintText: "Phone",
                              label: "Phone",
                              //obscureText: true,
                              controller: _phoneController,
                              validator: Validator.validatePhone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                              ],
                              width: 240,
                            ),
                            Container(
                              width: 110,
                              // height: 50,
                              // margin: EdgeInsets.only(right: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "WhatsApp",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Checkbox(
                                      value: hasWhatsApp.value,
                                      activeColor: Colors.green,
                                      onChanged: (checked) => {
                                            hasWhatsApp.value = checked ?? false
                                          }),
                                ],
                              ),
                            )
                          ]),
                      ElevatedButton(
                          onPressed: () => {
                                Get.to(ThanksScreen()),
                              },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 20,
                            shadowColor: Colors.grey.shade700,
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: Text("Checkout"))
                    ])));
          }),
        ]));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Get.theme.primaryColor,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Get.theme.primaryColor,
      // ),
      elevation: 0,
      title: Text("Checkout"),
      centerTitle: true,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
