import 'dart:io';

import 'package:akrem/Screens/basket/ImagePreview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../services/log_manager.dart';

class TakePic extends StatefulWidget {

  TakePic({
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
  Future<void> initState() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    super.initState();

    cameraInitialize();
  }
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
 void cameraInitialize(){
   _cameraController = CameraController(
       cameras[0], ResolutionPreset.max,
       enableAudio: false);
   _cameraController.initialize().then((_) {
     if (!mounted) {}
     setState(() {});
   }).catchError((Object e) {
     if (e is CameraException) {
       switch (e.code) {
         case 'CameraAccessDenied':
           LogManager.logToConsole("CameraAccessDenied");
           break;
         default:
           LogManager.logToConsole("${e.description}");
           break;
       }
     }
   });

 }
  @override
  Widget build(BuildContext context) {
    _cameraController.setFlashMode(FlashMode.auto);
    return Scaffold(
        body: Stack(children: <Widget>[
          Visibility(
            visible: camOn,
            child: Container(
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
                          return null;
                        }
                        if (_cameraController.value.isTakingPicture) {
                          return null;
                        }
                        try {
                          XFile pic = await _cameraController.takePicture();
                          //_cameraController.dispose();
                          setState(() {
                            lodding = false;
                            //camOn = false;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImagePreview(file: pic)),
                          );

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
      );
  }
}
