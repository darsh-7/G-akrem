import 'dart:developer';

import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/medic.dart';
import '../../widgets/medic_card.dart';
import '../../constants/app_colors.dart';
import 'add_medic.dart';
import 'empty_items.dart';

class MedicList extends StatefulWidget {
  MedicList({
    super.key,
  });

  @override
  State<MedicList> createState() => _MedicList();
}

class _MedicList extends State<MedicList> {
  final basketController = Get.put(BasketController());

  List<Medic> get _foundMedic {
    return basketController.medics;
  }

  //late get List<Medic> _foundMedic;
  late bool _isCameraPermissionGranted;

//  Image image = Image.asset(AppImages.profileIcon);

  @override
  void initState() {
    //_foundMedic = foundMedic;
    basketController.getMedics();
    super.initState();
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
      _isCameraPermissionGranted = true;
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
            // Get.back();
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
            child: const Icon(Icons.add,),
            onPressed: () async {
              getPermissionStatus();
            },
          ),
          SizedBox(
            height: 16,
          ),
          if (_foundMedic.isNotEmpty)
            FloatingActionButton(
            backgroundColor: Get.theme.primaryColor,
            child: const Icon(IconData(0xe156, fontFamily: 'MaterialIcons')),
            onPressed: () async {
              getPermissionStatus();
            },
          ),
          SizedBox(
            height: 8,
          ),
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
                              MedicManager.removeMedic(index: i);
                              //refreshList();
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // if (_foundMedic.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.only(bottom: 8.0),
                //     child: SizedBox(
                //       width: double.maxFinite,
                //       height: 45,
                //       child: ElevatedButton(
                //         onPressed: () {},
                //         child: const Text("Checkout"),
                //         style: ElevatedButton.styleFrom(
                //           shape: StadiumBorder(),
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ));
            //if (_foundMedic.isEmpty) const EmptyItemsScreen(),
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
        // Container(
        //   height: 40,
        //   width: 120,
        //   child: ClipRRect(
        //       borderRadius: BorderRadius.circular(20),
        //       child: IconButton(
        //         icon: const Icon(Icons.fiber_smart_record),
        //         onPressed: () => {
        //           //TODO : add voice recognition for adding items
        //         },
        //       )),
        // ),
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
