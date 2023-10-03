import 'dart:io';

import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Screens/map_screen.dart';
import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/main/show_pharm.dart';
import 'Screens/main/testpop.datr.dart';

const mainColor = Color(0xFF4672ff);

class MyApp extends StatelessWidget {

  MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Akrem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(mainColor),
            minimumSize: MaterialStateProperty.all(
              const Size.fromHeight(60),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
      ),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics!),
      // ],
      initialRoute: '/login',
      routes: {
        //  '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/loginn': (context) => LoginPagee(),
        '/main': (context) => NavigationBarApp(),
        '/register': (context) => RegisterPage(),
        '/map': (context) => MapSample(),
        '/basket': (context) => MedicList(),
        '/addMedic': (context) => AddMedic(pic: File(AppImages.profileIcon)),
        '/showPharm': (context) =>
            ShowPharm(pharm: Pharmacy.pharmacyList.first),
        '/cam': (context) =>
            TakePic(),

      },
    );
  }
}
