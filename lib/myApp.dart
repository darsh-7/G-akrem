
import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Screens/map/map_screen.dart';
import 'package:akrem/Screens/welcome/introduction_page.dart';
import 'package:akrem/Screens/welcome/welcome_page.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_local.dart';
import 'package:akrem/controller/controller_mang.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/main/show_branch.dart';
import 'Screens/map/Select_location_text.dart';

String startScreen="";
class MyApp extends StatelessWidget {
  UserController userController = Get.put(UserController());
  MyApp({
    super.key,
    required this.userController,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // print(" token val :${(ControllerManager.userController.user).token}");
    // print("locationString val :${(ControllerManager.userController.user).locationString}");
    print(" token val :${(userController.user).token}");
    print("locationString val :${(userController.user).locationString}");

    if ((userController.user).token == null) {
      print("go to welcome");
      startScreen = "/welcome";
    } else {
      if ((userController.user).locationString == null) {
        print("go to main");
        startScreen = "/map";
      }  else{
        print("go to main");
        startScreen = "/main";
      }

    }


    return GetBuilder<UserController>(builder: (_){
      return GetMaterialApp(
        localizationsDelegates: [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
        //locale: Locale('ar'),
        localeResolutionCallback: (currentLang, supportLang) {
          if (currentLang != null) {
            for (Locale locale in supportLang) {
              if (locale.languageCode == currentLang.languageCode) {
                //mySharedPreferences.setString("lang",currentLang.languageCode) ;
                return currentLang;
              }
            }
          }
          return supportLang.first;
        },
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
                secondary:  Colors.white,
                onSecondary: AppColors.mainColor,
                error: Colors.red,
                onError: Colors.red,
                background: Colors.white,
                onBackground: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black),

            floatingActionButtonTheme: FloatingActionButtonThemeData(

            ),
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
            datePickerTheme: DatePickerThemeData(
              surfaceTintColor: Colors.black, // header text color
              backgroundColor: Get.theme.cardColor,

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
                secondary:  Colors.white,
                onSecondary: AppColors.mainColor,
                error: Colors.red,
                onError: Colors.red,
                background: AppColors.darkGround,
                onBackground: AppColors.darkGround,
                surface: Colors.black,
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
            datePickerTheme: DatePickerThemeData(
              surfaceTintColor: Colors.white, // header text color
              backgroundColor: Colors.black,

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

        initialRoute: startScreen,
        routes: {
          //  '/': (context) => SplashPage(),
          '/test': (context) => const TouristDetailsPage(
              image: "https://via.placeholder.com/600/d32776"),
          '/welcome': (context) => const WelcomePage(),
          '/login': (context) => const LoginPage(),
          '/main': (context) => NavigationBarApp(),
          '/register': (context) => const RegisterPage(),
          '/map': (context) => SelectLocation(),
          '/basket': (context) => MedicList(),
          '/addMedic': (context) => AddMedic(),
          '/showPharm': (context) =>
              ShowPharm(pharm: Pharmacy.pharmacyList.first),
          '/cam': (context) => const TakePic(),
        },
      );
    });
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
