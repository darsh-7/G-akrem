import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/myApp.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late List<CameraDescription> cameras;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp( MyApp(cameraDescription: cameras,));
}
