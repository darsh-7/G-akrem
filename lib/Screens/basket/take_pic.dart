import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:akrem/Screens/basket/ImagePreview.dart';
import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';

class TakePic extends StatefulWidget {
  const TakePic({
    super.key,
  });

  @override
  State<TakePic> createState() => _TakePic();
}

class _TakePic extends State<TakePic> {
  bool lodding = false;
  bool camOn = true;
  late CameraController _cameraController;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    if (Get.arguments["camera"] == null) {
      Get.offAll(NavigationBarApp());
      return;
    }
    cameras = Get.arguments["camera"];
    WidgetsFlutterBinding.ensureInitialized();

    super.initState();

    cameraInitialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void cameraInitialize() {
    _cameraController =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    _cameraController.initialize().then((_) {
      if (!mounted) {}
      setState(() {});
      _cameraController.setFlashMode(FlashMode.auto);
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            dev.log("CameraAccessDenied");
            break;
          default:
            dev.log("${e.description}");
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Scaffold(
        body: Stack(children: <Widget>[
          Visibility(
            // visible: camOn,
            child: SizedBox(
              height: double.infinity,
              child: CameraPreview(_cameraController),
            ),
          ),
          Visibility(
            visible: lodding,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.red,
                child: const Text(
                  "Please take a vertical photo of the medicine",
                  style: TextStyle(fontSize: 30),
                ),
              )),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOut,
            ), // This one will create the magic
            child: Stack(fit: StackFit.expand, children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.3,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30), right: Radius.circular(30)
                        // MediaQuery.of(context).size.width / 2,
                        ),
                  ),
                ),
              ),
            ]),
          ),
          Container(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(20),
                height: 50,
               width: 50,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30), right: Radius.circular(30)
                    // MediaQuery.of(context).size.width / 2,
                  ),
                ),
                child: Icon(
                  Icons.help,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: RawMaterialButton(
                      child: const Icon(Icons.camera),
                      onPressed: () async {
                        setState(() {
                          lodding = true;
                        });
                        if (!_cameraController.value.isInitialized) {
                          dev.log('Camera is not Initialized : error');
                          return null;
                        }
                        if (_cameraController.value.isTakingPicture) {
                          dev.log('Camera isTakingPicture: error');
                          return null;
                        }
                        try {
                          XFile xPic = await _cameraController.takePicture();
                          //_cameraController.dispose();
                          setState(() {
                            lodding = false;
                          });
                          // image = img.copyCrop(image, x:5, y:5, width: 100, height:100);

                          //var pic =image.buffer.asUint8List();

                          File pic = File(xPic.path);

                          final croppedFile = await ImageCropper().cropImage(
                            sourcePath: pic.path,
                            compressFormat: ImageCompressFormat.jpg,
                            compressQuality: 100,
                            uiSettings: [
                              AndroidUiSettings(
                                  toolbarTitle: 'Crop Medic',
                                  toolbarColor: Get.theme.primaryColor,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio:
                                      CropAspectRatioPreset.ratio3x2,
                                  cropGridColumnCount: 30,
                                  cropGridRowCount: 50,
                                  lockAspectRatio: true,
                                  hideBottomControls: true,
                              ),
                              IOSUiSettings(
                                title: 'Cropper',
                              ),
                              WebUiSettings(
                                context: context,
                                presentStyle: CropperPresentStyle.dialog,
                                boundary: const CroppieBoundary(
                                  width: 520,
                                  height: 520,
                                ),
                                viewPort: const CroppieViewPort(
                                    width: 480, height: 480, type: 'circle'),
                                enableExif: true,
                                enableZoom: true,
                                showZoomer: true,
                              ),
                            ],
                          );

                          if (croppedFile == null) {
                            return;
                          }

                          var imgBytes = await croppedFile.readAsBytes();
                          //pic.delete();

                          Get.to(() => AddMedic(), arguments: {
                            "picFile": imgBytes,
                          });
                        } on CameraException catch (e) {
                          debugPrint("takePicture error");
                          return null;
                        }
                        // cameraInitialize();
                        // setState(() {
                        //   camOn = true;
                        // });
                      }),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
