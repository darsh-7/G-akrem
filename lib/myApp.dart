import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/Screens/customer_screen/provider/cart.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Screens/map/Select_location.dart';
import 'package:akrem/Screens/welcome/welcome_page.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_local.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/widgets/info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'Screens/main/show_branch.dart';

String startScreen = "";

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
        print("${userController.user.locationString}");
        print("go to map");
        startScreen = "/map";
      } else {
        print("go to main");
        startScreen = "/main";
      }
    }
    ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
    );
    return ChangeNotifierProvider<Cart>(create: (context) {
      return Cart();
    }, builder: (context, child) {
      return GetBuilder<UserController>(builder: (_) {
        return GetMaterialApp(
          localizationsDelegates: [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', "EG"), // Arabic
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
          locale: Locale('en', 'US'),
          // Arabic

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
                  secondary: Colors.white,
                  onSecondary: AppColors.mainColor,
                  error: Colors.red,
                  onError: Colors.red,
                  surface: Colors.black,
                  onSurface: Colors.black),
              floatingActionButtonTheme: FloatingActionButtonThemeData(),
              //scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColors.mainColor),
                  //textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),

                  // minimumSize: MaterialStateProperty.all(
                  //   const Size.fromHeight(60),
                  // ),
                  shape: WidgetStateProperty.all(
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
                backgroundColor: Get.theme.cardColor,
              ),
              appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.mainColor,
                  iconTheme: IconThemeData(color: Colors.white),
                  foregroundColor: Colors.white)),

          //dark

          darkTheme: ThemeData.dark().copyWith(
              primaryColor: AppColors.darkBlue,
              shadowColor: Colors.white,
              cardColor: AppColors.darkGround,
              scaffoldBackgroundColor: AppColors.darkGround,
              colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: AppColors.darkBlue,
                  onPrimary: AppColors.mainColor,
                  secondary: Colors.white,
                  onSecondary: AppColors.mainColor,
                  error: Colors.red,
                  onError: Colors.red,
                  surface: Colors.black,
                  onSurface: Colors.white),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColors.darkBlue),
                  //textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  // minimumSize: MaterialStateProperty.all(
                  //   const Size.fromHeight(60),
                  // ),
                  shape: WidgetStateProperty.all(
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

          //initialRoute: "/test",
          initialRoute: startScreen,

          routes: {
            //  '/': (context) => SplashPage(),
            '/test': (context) => CustomInfoWindowExample(),
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
