import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/medic_basket.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Screens/map_screen.dart';
import 'package:akrem/Api/fake_api.dart';
import 'package:flutter/material.dart';

import 'Screens/main/show_pharm.dart';


const mainColor = Color(0xFF4672ff);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
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
      initialRoute: '/showPharm',
      routes: {
      //  '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/main': (context) => NavigationBarApp(),
        '/register': (context) => RegisterPage(),
        '/map': (context) => MapSample(),
        '/basket': (context) => MedicBasket(),
        '/addMedic': (context) => AddMedic(),
        '/showPharm': (context) => ShowPharm(pharm: Pharmacy.pharmacyList.first),
      },
    );
  }
}