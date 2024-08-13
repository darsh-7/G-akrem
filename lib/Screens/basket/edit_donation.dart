import 'dart:developer';

import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/medic.dart';
import '../../widgets/medic_card.dart';
import '../../constants/app_colors.dart';
import 'empty_items.dart';

class EditDonation extends StatefulWidget {
  EditDonation({
    super.key,
  });

  @override
  State<EditDonation> createState() => _EditDonation();
}

class _EditDonation extends State<EditDonation> {
  final basketController = Get.put(BasketController());
  final UserController userController = Get.find();

  late List<Medic> _foundMedic;

  @override
  void initState() {
    //_foundMedic = foundMedic;
    //basketController.getMedics();
    getMed();
    super.initState();
  }

  Future<void> getMed() async {
    print("med called 1");

    final ByteData bytes = await rootBundle.load(AppImages.noImage);
    final Uint8List list = bytes.buffer.asUint8List();
    setState(() {
      _foundMedic = [
        Medic(img: list, name: 'med 1',date: DateTime.now(),pill: 2,bar: 3),
        Medic(img: list, name: 'med 1',date: DateTime.now(),pill: 2,bar: 3),      ];
    });

  }

  // void refreshList() {
  //   List<Medic> results = MedicManager.medics;
  //   setState(() {
  //     _foundMedic = results;
  //   });
  // }

  getPermissionStatus() async {
    //await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      log('Camera Permission: GRANTED');
      await Get.to(() => const TakePic(),
          arguments: {"camera": await availableCameras()});
    } else {
      log('Camera Permission: DENIED');
      Get.defaultDialog(
        title: "Permission Needed",
        titleStyle: const TextStyle(fontSize: 20),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
              "On the next step we need to use the camera to take picture of the Medic you want to donate.\n if you agry pleas press agree"),
        ),
        confirm: ElevatedButton(
          onPressed: () async {
            Get.back();
            await Permission.camera.request();
            status = await Permission.camera.status;
            if (status.isGranted) {
              await Get.to(const TakePic(),
                  arguments: {"camera": await availableCameras()});
            } else {
              Get.defaultDialog(
                title: "Permission Needed",
                content: const Text(
                    "Sorry we cant add any medic with out the Camera"),
                cancel: OutlinedButton(
                    onPressed: () => Get.back(), child: const Text("ok")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor, side: BorderSide.none),
          child: const Text("Agree"),
        ),
        cancel: OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.red),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.positives,
            heroTag: "btn1",
            child: const Icon(
              Icons.add,
            ),
            onPressed: () async {
              getPermissionStatus();
            },
          ),
          SizedBox(
            height: 16,
          ),
          GetBuilder<BasketController>(builder: (_) {
            if (_foundMedic.isNotEmpty)
              return FloatingActionButton(
                backgroundColor: Get.theme.primaryColor,
                heroTag: "btn2",
                child: const Icon(
                  IconData(0xe156, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (userController.user.token == null) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Close")),
                                TextButton(
                                    onPressed: () {
                                      Get.offAll(LoginPage());
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Get.theme.primaryColor),
                                    ))
                              ],
                              title: const Text("have not login yet"),
                              content: const Text(
                                  "To proceed you have to login\nLOGIN NOW!"),
                            ));
                  } else {
                    Get.back();
                  }
                },
              );
            else
              return SizedBox(
                height: 8,
              );
          }),
        ],
      ),

      //appBar: _buildAppBar(),
      body: Stack(
        children: [
          GetBuilder<BasketController>(builder: (_) {
            if (_foundMedic.isEmpty) return const EmptyItemsScreen();
            return Container(
                child: Column(
              children: [
                //TextButton(onPressed: () => {refreshList()}, child: Text("tap")),
                //const LinearProgressIndicator(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 80, top: 10),
                    children: [
                      for (var i = 0; i < _foundMedic.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: MedicCard(
                            img: _foundMedic[i].img,
                            name: _foundMedic[i].name,
                            pill: _foundMedic[i].pill,
                            bar: _foundMedic[i].bar,
                            date: _foundMedic[i].date,
                            index: i,
                            onDelete: (i) {
                              basketController.removeMedic(index: i);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ));
          }),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text("Donation basket"),
        ]),

        Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red.withOpacity(0.8),
          ),
          child: TextButton(
            child: const Text(
              "Clear",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Close")),
                          TextButton(
                              onPressed: () {
                                basketController.clearList();
                                Get.back();
                              },
                              child: const Text(
                                "Clear",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                        title: const Text("are you sure"),
                        content: const Text(
                            "click Clear if you are sure to remove all items from the basket"),
                      ));
            },
          ),
        ),
      ]),
    );
  }
}
