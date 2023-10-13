import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:akrem/Screens/basket/ImagePreview.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  "please enter the medic in the lite box",
                  style: TextStyle(fontSize: 40),
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
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 18, right: 18),
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
                          File pic = File(xPic.path);
                           Get.to(()=> ImagePreview(), arguments: {
                            "picFile": pic,
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
