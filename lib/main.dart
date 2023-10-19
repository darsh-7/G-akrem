import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/controller/controller_mang.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/medic.dart';
import 'package:akrem/model/user.dart';
import 'package:akrem/myApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MedicAdapter());
  Hive.registerAdapter(UserAdapter());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: (Get.isDarkMode ? AppColors.mainColor:AppColors.darkBlue), // navigation bar color
    statusBarColor: (Get.isDarkMode ? AppColors.mainColor:AppColors.darkBlue),  // status bar color
  ));

  var user = Get.put(UserController());
  await user.getUser();

  runApp( MyApp(userController: user,));
}
