import 'package:akrem/Screens/NavigationBar.dart';
import 'package:akrem/Screens/home_screen.dart';
import 'package:akrem/Screens/login_page.dart';
import 'package:akrem/Screens/map_screen.dart';
import 'package:akrem/Screens/register_page.dart';
import 'package:flutter/material.dart';


const mainColor = Color(0xFF4672ff);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(mainColor),
            minimumSize: MaterialStateProperty.all(
              Size.fromHeight(60),
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
      initialRoute: '/main',
      routes: {
      //  '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/main': (context) => NavigationBarApp(),
        '/register': (context) => RegisterPage(),
        '/map': (context) => MapSample(),
      },
    );
  }
}