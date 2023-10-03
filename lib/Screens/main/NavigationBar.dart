import 'dart:ui';

import 'package:akrem/Screens/main/home_screen.dart';
import 'package:akrem/Screens/main/Profile/profle_Screen.dart';
import 'package:akrem/Screens/show_branchs.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      extendBody: true,
      //extendBodyBehindAppBar: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
              backgroundColor: Colors.white.withAlpha(150),
              indicatorColor: Colors.transparent,
              selectedIndex: currentPageIndex,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: AppColors.mainColor,
                      ),
                      child: const Icon(Icons
                          .home_outlined) //Image.asset(AppImages.boxIcon,scale: 6),
                      ),
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    AppImages.fastDonation,
                    color: Colors.black,
                  ),
                  selectedIcon: Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: AppColors.mainColor,
                    ),
                    child: SvgPicture.asset(
                      AppImages.fastDonation,
                      color: Colors.black,
                    ),
                  ),
                  label: "Donation",
                ),
                NavigationDestination(
                  icon: const Icon(Icons.attach_money),
                  selectedIcon: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: AppColors.mainColor,
                      ),
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
                      backgroundColor: AppColors.mainColor,
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
        const Center(
          child: Text("fast order"),
        ),
        const Center(
          child: Text("fund page"),
        ),
        const ProfileScreen(),
      ][currentPageIndex],
    );
  }
}
