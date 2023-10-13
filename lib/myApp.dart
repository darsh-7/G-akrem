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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/main/show_pharm.dart';

const mainColor = AppColors.darkGround;

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

      //themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
       themeMode: ThemeMode.system,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          primaryColor: AppColors.mainColor,
          useMaterial3: true,
          cardColor: Colors.white,
          shadowColor: Colors.black,
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              secondary: AppColors.mainColor,
              onSecondary: AppColors.mainColor,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.white,
              onBackground: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black),

          //scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
              //textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
              foregroundColor: MaterialStateProperty.all(Colors.white),

              // minimumSize: MaterialStateProperty.all(
              //   const Size.fromHeight(60),
              // ),
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
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainColor)),

      //dark

      darkTheme: ThemeData.dark().copyWith(
          primaryColor: AppColors.darkBlue,
          shadowColor: Colors.white,
          useMaterial3: true,
          cardColor: AppColors.darkGround,
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
              surface: Colors.white,
              onSurface: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.darkBlue),
              //textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              // minimumSize: MaterialStateProperty.all(
              //   const Size.fromHeight(60),
              // ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.darkBlue,
          )),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics!),
      // ],

      initialRoute: '/welcome',
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

  // ThemeData _buildTheme(Brightness brightness) {
  //   var baseTheme = ThemeData(brightness: brightness);
  //
  //   return baseTheme.copyWith(
  //     // colorScheme: _customColorScheme,
  //     // textTheme: GoogleFonts.lobsterTextTheme(baseTheme.textTheme),
  //     useMaterial3: true,
  //   );
  // }
}
