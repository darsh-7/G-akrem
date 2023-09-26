import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/myApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,
  ));

  runApp(const MyApp());
}
