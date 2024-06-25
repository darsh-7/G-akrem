import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:akrem/Api/ocr_model.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:akrem/Screens/basket/ImagePreview.dart';
import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/totorial_video.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:camera/camera.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

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
  final textRecognizer = TextRecognizer();

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
    textRecognizer.close();
    super.dispose();
  }

  void cameraInitialize() {
    _cameraController =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    _cameraController.initialize().then((_) {
      if (!mounted) {}
      setState(() {});
      _cameraController.setFlashMode(FlashMode.off);
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
                color: AppColors.mainColor,
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
                  child: InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext builder) {
                          return CupertinoPopupSurface(child: VideoApp());
                        },
                      );
                    },
                    child: Icon(
                      Icons.help,
                    ),
                  ))),
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


                         //final croppedFile = pic;
                          

                          // final objectDetector = ObjectDetector(options: ObjectDetectorOptions(mode: mode, classifyObjects: classifyObjects, multipleObjects: multipleObjects));
                          //
                          // final List<DetectedObject> objects = await objectDetector.processImage(InputImage.fromFilePath(pic.path));
                          //
                          // for(DetectedObject detectedObject in objects){
                          //   final rect = detectedObject.boundingBox;
                          //   final trackingId = detectedObject.trackingId;
                          //
                          //   for(Label label in detectedObject.labels){
                          //     print('${label.text} ${label.confidence}');
                          //   }
                          // }
                          // try {
                          //   //Make sure to await the call to detectEdge.
                          //   bool success = await EdgeDetection.detectEdge(pic.path,
                          //     canUseGallery: true,
                          //     androidScanTitle: 'Scanning', // use custom localizations for android
                          //     androidCropTitle: 'Crop',
                          //     androidCropBlackWhiteTitle: 'Black White',
                          //     androidCropReset: 'Reset',
                          //
                          //   );
                          // } catch (e) {
                          //   print(e);
                          // }

                          final croppedFile = await ImageCropper().cropImage(
                            sourcePath: pic.path,
                            compressFormat: ImageCompressFormat.jpg,
                            compressQuality: 100,
                            uiSettings: [
                              AndroidUiSettings(
                                toolbarTitle: 'Crop Medic',
                                toolbarColor: Get.theme.primaryColor,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.ratio3x2,
                                // cropGridColumnCount: 30,
                                // cropGridRowCount: 50,
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
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );

                          int id = 4712;
                          String medicName = "";
                          String medicConcentration = "";
                          String medicTablets = "";
                          final String ocrText ="";
                          var connectivityResult = await (Connectivity().checkConnectivity());

                          if (connectivityResult != ConnectivityResult.none) {
                            // I am connected to a mobile network.

                            final bytes = File(croppedFile.path);
                            Map<String,dynamic> res = await OcRModelAPI.postImageToServer(bytes);

                           // medicName = res["responseJson"][];



                          if(res["responseJson"] == 0||medicName.isEmpty||medicName == ""){
                            final inputImage =
                            InputImage.fromFile(File(croppedFile.path));

                            final recognizedText =
                            await textRecognizer.processImage(inputImage);


                            double biggestVertical = 0;
                            double biggestHorizontal = 0;

                            for (TextBlock block in recognizedText.blocks) {
                              for (TextLine line in block.lines) {
                                Rect frame = line.elements.first.boundingBox;
                                print(
                                    "vaal ${line.elements.first.text} : ${line.elements.first.text.contains("mg") || line.elements.first.text.contains("MG")}");
                                if (_isNumeric(line.elements.first.text)) {
                                  line.elements.toList().forEach((element) {
                                    if (element.text.contains("mg") ||
                                        element.text.contains("MG")) {
                                      print(
                                          "found Concentration : ${line.elements.toString()}");
                                      //medicNum = line.elements.toString();
                                      medicConcentration = medicConcentration +
                                          " " +
                                          line.elements.first.text +
                                          element.text +
                                          " ";
                                    } else if (element.text.contains("tablets") ||
                                        element.text.contains("Tablets")) {
                                      print(
                                          "found Concentration : ${line.elements.toString()}");
                                      //medicNum = line.elements.first.text;
                                      medicTablets = line.elements.first.text;
                                    } else {
                                      if (medicTablets.isEmpty) {
                                        medicTablets = line.elements.first.text;
                                      } else if (medicConcentration.isEmpty) {
                                        medicConcentration =
                                            line.elements.first.text;
                                      }
                                    }
                                  });
                                  continue;
                                }

                                if (biggestVertical <
                                    (frame.bottom - frame.top) &&
                                    biggestHorizontal <
                                        (frame.right - frame.left)) {
                                  print(
                                      "medicName : ${line.elements.first.text} bigger than ${medicName}");
                                  biggestVertical = frame.bottom - frame.top;
                                  biggestHorizontal = frame.right - frame.left;
                                  medicName = line.elements.first.text;
                                }

                              }



                              // for (TextElement element in line.elements) {
                              //
                              //   if (biggestVertical < (element.boundingBox.bottom - element.boundingBox.top)/* && biggestHorizontal < (element.boundingBox.right - element.boundingBox.left)*/) {
                              //     print ("medicName : ${element.text} bigger than ${medicName}");
                              //     biggestVertical = element.boundingBox.bottom - element.boundingBox.top;
                              //     biggestHorizontal =element.boundingBox.right - element.boundingBox.left;
                              //     medicName = element.text;
                              //   }
                              //
                              //   // Do something with fontSize, e.g. add to a list
                              // }

                              // Do something with fontSize, e.g. add to a list
                            }
                          }

                          } else  {
                            // I am connected to a wifi network.

                            final inputImage =
                            InputImage.fromFile(File(croppedFile.path));

                            final recognizedText =
                            await textRecognizer.processImage(inputImage);


                            double biggestVertical = 0;
                            double biggestHorizontal = 0;

                            for (TextBlock block in recognizedText.blocks) {
                              for (TextLine line in block.lines) {
                                Rect frame = line.elements.first.boundingBox;
                                print(
                                    "vaal ${line.elements.first.text} : ${line.elements.first.text.contains("mg") || line.elements.first.text.contains("MG")}");
                                if (_isNumeric(line.elements.first.text)) {
                                  line.elements.toList().forEach((element) {
                                    if (element.text.contains("mg") ||
                                        element.text.contains("MG")) {
                                      print(
                                          "found Concentration : ${line.elements.toString()}");
                                      //medicNum = line.elements.toString();
                                      medicConcentration = medicConcentration +
                                          " " +
                                          line.elements.first.text +
                                          element.text +
                                          " ";
                                    } else if (element.text.contains("tablets") ||
                                        element.text.contains("Tablets")) {
                                      print(
                                          "found Concentration : ${line.elements.toString()}");
                                      //medicNum = line.elements.first.text;
                                      medicTablets = line.elements.first.text;
                                    } else {
                                      if (medicTablets.isEmpty) {
                                        medicTablets = line.elements.first.text;
                                      } else if (medicConcentration.isEmpty) {
                                        medicConcentration =
                                            line.elements.first.text;
                                      }
                                    }
                                  });
                                  continue;
                                }

                                if (biggestVertical <
                                    (frame.bottom - frame.top) &&
                                    biggestHorizontal <
                                        (frame.right - frame.left)) {
                                  print(
                                      "medicName : ${line.elements.first.text} bigger than ${medicName}");
                                  biggestVertical = frame.bottom - frame.top;
                                  biggestHorizontal = frame.right - frame.left;
                                  medicName = line.elements.first.text;
                                }

                              }



                              // for (TextElement element in line.elements) {
                              //
                              //   if (biggestVertical < (element.boundingBox.bottom - element.boundingBox.top)/* && biggestHorizontal < (element.boundingBox.right - element.boundingBox.left)*/) {
                              //     print ("medicName : ${element.text} bigger than ${medicName}");
                              //     biggestVertical = element.boundingBox.bottom - element.boundingBox.top;
                              //     biggestHorizontal =element.boundingBox.right - element.boundingBox.left;
                              //     medicName = element.text;
                              //   }
                              //
                              //   // Do something with fontSize, e.g. add to a list
                              // }

                              // Do something with fontSize, e.g. add to a list
                            }
                          }

                          // for (TextBlock block in recognizedText.blocks) {
                          //   double topPoint = 0;
                          //   double rightPoint = 0;
                          //
                          //   String topText = "";
                          //   final Rect rect = block.boundingBox;
                          //   final List<Point<int>> cornerPoints =
                          //       block.cornerPoints;
                          //   final String text = block.text;
                          //   //final List<String> languages = block.recognizedLanguages;
                          //   print("element : ${rect}");
                          //   print("cornerPoints : ${cornerPoints}");
                          //   print("text : ${text}");
                          //   // print("languages : ${languages}");\
                          //
                          //   for (TextLine line in block.lines) {
                          //     // Same getters as TextBlock
                          //     for (TextElement element in line.elements) {
                          //       // Same getters as TextBlock
                          //       // if (element.text.contains("mg") ||
                          //       //     element.text.contains("g")) {
                          //       //   if (text.contains("gsk") ||
                          //       //       text.contains("LE") ||
                          //       //       text.length > 13) {
                          //       //     continue;
                          //       //   }
                          //       //   medicNum = element.text;
                          //       // }
                          //       if (element.boundingBox.right > rightPoint &&element.boundingBox.top > topPoint && isUppercase(element.text[0])) {
                          //         if (text.contains("gsk")) {
                          //           continue;
                          //         }
                          //         topPoint = element.boundingBox.top;
                          //         rightPoint = element.boundingBox.right;
                          //         medicName = element.text;
                          //       }
                          //       print("element : ${element.text}");
                          //     }
                          //   }
                          // }

                          var imgBytes = await croppedFile.readAsBytes();
                          //pic.delete();
                          Get.back();
                          Get.to(() => AddMedic(), arguments: {
                            "picFile": imgBytes,
                            "text": ocrText,
                            "medicName": medicName,
                            "medicConcentration": medicConcentration,
                            "medicTablets": medicTablets
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

bool isUppercase(String str) {
  return str == str.toUpperCase();
}

bool _isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}


