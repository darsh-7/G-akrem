import 'dart:ui';

import 'package:akrem/Screens/main/Fund.dart';
import 'package:akrem/Screens/main/home_screen.dart';
import 'package:akrem/Screens/main/Profile/profle_Screen.dart';
import 'package:akrem/Screens/main/show_branchs.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Flutter code sample for [NavigationBar].

// void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatefulWidget {
  NavigationBarApp({
    super.key,
  });

  @override
  State<NavigationBarApp> createState() => _NavigationBarApp();
}

class _NavigationBarApp extends State<NavigationBarApp> {
  int currentPageIndex = 0;
  Image image = Image.asset(
    AppImages.profileIcon,
  );
  var radius = const Radius.circular(10);

// @override
  // void initState() {
  // showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Close"))
  //       ],
  //       title: const Text("Welcome, Admin, to Akram "),
  //       content: Text("we are good"),
  //     ));
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "NO",
                          style: TextStyle(color: AppColors.positives),
                        )),
                    TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: const Text("Leave",
                            style: TextStyle(color: AppColors.negative)))
                  ],
                  title: const Text("want to leave? "),
                  content: const Text(
                      "Are you sure you want to leave the app? \n if yse click leave other with click no"),
                ));
        return false;
      },
      child: Scaffold(
        extendBody: true,
        //extendBodyBehindAppBar: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
          child: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                height: 4 * 15,
                //surfaceTintColor: Colors.red,
                //shadowColor: Colors.red,
                //backgroundColor: Get.theme.navigationBarTheme.backgroundColor,

                backgroundColor: Get.theme.colorScheme.background.withAlpha(150),
                indicatorColor: Colors.transparent,
                selectedIndex: currentPageIndex,
                destinations: <Widget>[
                  NavigationDestination(
                    selectedIcon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                         // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .home_outlined) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .home_outlined) //Image.asset(AppImages.boxIcon,scale: 6),
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.location_on_rounded),
                    selectedIcon: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        //color: AppColors.mainColor,
                      ),
                      child: const Icon(Icons.location_on_rounded),
                    ),
                    label: "Map",
                  ),
                  NavigationDestination(
                    icon:  Container(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(AppImages.akremLogoSVG,color: Colors.white,)),
                    selectedIcon: Container(
                      width: 40,
                      height: 40,
                      child: SvgPicture.asset(AppImages.akremLogoSVG,color: Get.theme.primaryColor,),
                      //child: const Icon(Icons.fast_forward),
                    ),
                    label: "Donation",
                  ),
                  NavigationDestination(
                    icon: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.attach_money),
                    ),
                    selectedIcon: SizedBox(
                        width: 40,
                        height: 40,
                        child: const Icon(Icons
                            .attach_money) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    label: "Fund",
                  ),
                  NavigationDestination(
                    //selectedIcon: Image.asset("icons/icon-profile-circle.png"),
                    selectedIcon: Container(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Get.theme.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4), // Border radius
                          child: ClipOval(child: image),
                        ),
                      ),
                    ),

                    icon: Container(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: image,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: <Widget>[
          Home(),
          Center(
            child: ElevatedButton(onPressed: () => {}, child: Text("Start")),
          ),
          Center(
            child: Text("Start"),
          ),
          Fund(),
          const ProfileScreen(),
        ][currentPageIndex],
      ),
    );
  }
}
