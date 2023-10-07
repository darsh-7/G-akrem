import 'dart:io';

import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Screens/map_screen.dart';
import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Screens/welcome/introduction_page.dart';
import 'package:akrem/Screens/welcome/welcome_page.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/main/show_pharm.dart';

const mainColor = Color.fromRGBO(3, 134, 208, 1);

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akrem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
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
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backGround,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.blue.shade800,
          shadowColor: Colors.black,
          cardColor: AppColors.darkBlue,
          scaffoldBackgroundColor: AppColors.darkGround,
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: AppColors.darkBlue,
              onPrimary: AppColors.mainColor,
              secondary: AppColors.mainColor,
              onSecondary: AppColors.mainColor,
              error: Colors.red,
              onError: Colors.red,
              background: AppColors.darkGround,
              onBackground: AppColors.darkGround,
              surface: Colors.greenAccent,
              onSurface: Colors.greenAccent),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
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
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.darkBlue,
          )

      ),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics!),
      // ],
      initialRoute: '/login',
      routes: {
        //  '/': (context) => SplashPage(),
        '/test': (context) => const TouristDetailsPage(
            image: "https://via.placeholder.com/600/d32776"),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => NavigationBarApp(),
        '/register': (context) => const RegisterPage(),
        '/map': (context) => const MapSample(),
        '/basket': (context) => MedicList(),
        '/addMedic': (context) => AddMedic(),
        '/showPharm': (context) =>
            ShowPharm(pharm: Pharmacy.pharmacyList.first),
        '/cam': (context) => const TakePic(),
      },
    );
  }
}
