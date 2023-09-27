import 'package:akrem/Screens/basket/ImagePreview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../services/log_manager.dart';

class TakePic extends StatefulWidget {
  final List<CameraDescription> cameraDescription;

  TakePic({
    super.key,
    required this.cameraDescription,
  });

  @override
  State<TakePic> createState() => _TakePic();
}

class _TakePic extends State<TakePic> {
  bool lodding = false;
  bool camOn = true;
  late CameraController _cameraController;

  @override
  void initState() {
    cameraInitialize();
  }
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
 void cameraInitialize(){
   _cameraController = CameraController(
       widget.cameraDescription[0], ResolutionPreset.max,
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
  void _moveToScreen2(BuildContext context) =>
      Navigator.pushReplacementNamed(context, "screen2");

  @override
  Widget build(BuildContext context) {
    _cameraController.setFlashMode(FlashMode.always);
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
            child: Center(
              child: const CircularProgressIndicator(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: RawMaterialButton(
                      child: Icon(Icons.camera),
                      onPressed: () async {
                        setState(() {
                          lodding = true;
                          camOn = false;
                        });
                        if (!_cameraController.value.isInitialized) {
                          return null;
                        }
                        if (_cameraController.value.isTakingPicture) {
                          return null;
                        }
                        try {
                          XFile pic = await _cameraController.takePicture();
                          _cameraController.dispose();
                          setState(() {
                            lodding = false;
                          });
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImagePreview(file: pic)),
                          );

                        } on CameraException catch (e) {
                          debugPrint("takePicture error");
                          return null;
                        }
                        cameraInitialize();
                        setState(() {
                          camOn = true;
                        });

                      }),
                ),
              )
            ],
          ),
        ]),
      );
  }
}
