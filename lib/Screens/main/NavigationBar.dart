import 'dart:ui';

import 'package:akrem/Screens/customer_screen/Home/NavigationBar.dart';
import 'package:akrem/Screens/customer_screen/Home/basket_page.dart';
import 'package:akrem/Screens/main/Fund.dart';
import 'package:akrem/Screens/main/reward.dart';
import 'package:akrem/Screens/main/home_screen.dart';
import 'package:akrem/Screens/main/Profile/profle_Screen.dart';
import 'package:akrem/Screens/main/show_branchs.dart';
import 'package:akrem/Screens/map/branchs_map.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/constants/app_local.dart';
import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatefulWidget {
  NavigationBarApp({
    super.key,
  });

  @override
  State<NavigationBarApp> createState() => _NavigationBarApp();
}

UserController userController = Get.find();

var profileImg = NetworkImage(userController.user.img ??
    "https://res.cloudinary.com/drmmayia1/image/upload/v1697917708/SmartMedicinePlatform/yyvplvxqd2vciyzppcsg.png");

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
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.blue, // status bar color
    ));
    super.initState();
    final ShoppingCardController shoppingCardController = Get.put(ShoppingCardController());

  }

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
                  title: const Text("Want to leave? "),
                  content: const Text(
                      "Are you sure you want to leave the app? \n if yse click leave other with click NO"),
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
                height: 4 * 14,
                //surfaceTintColor: Colors.red,
                //shadowColor: Colors.red,
                //backgroundColor: Get.theme.navigationBarTheme.backgroundColor,

                backgroundColor:
                    Get.theme.colorScheme.background.withAlpha(150),
                indicatorColor: Colors.transparent,
                selectedIndex: currentPageIndex,
                destinations: <Widget>[
                  NavigationDestination(
                    selectedIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: const Icon(Icons
                            .home) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    icon: SizedBox(
                        width: 24,
                        height: 24,
                        child: const Icon(Icons
                            .home_outlined) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    label: getLang(context, "Home"),
                  ),
                  NavigationDestination(
                    icon: SizedBox(
                      width: 24,
                      height: 24,

                      child: const Icon(Icons.location_on_outlined),
                    ),
                    selectedIcon: SizedBox(
                      width: 24,
                      height: 24,

                      child: const Icon(Icons.location_on_rounded),
                    ),
                    label: getLang(context, "Locations"),
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       Get.offAll(CustomerNavigationBar());
                  //     },
                  //     child: Container(
                  //         // width: 40,
                  //         // height: MediaQuery.of(context).padding.bottom + 200,
                  //         decoration: BoxDecoration(
                  //             // color: Get.theme.primaryColor,
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(100))),
                  //         child: Column(
                  //           children: [
                  //             Container(
                  //               height: 40,
                  //               width: 40,
                  //               //padding: EdgeInsets.all(4),
                  //               child: SvgPicture.asset(
                  //                 AppImages.akremLogoSVG,
                  //                 colorFilter: ColorFilter.mode(
                  //                     Get.theme.shadowColor, BlendMode.srcIn),
                  //               ),
                  //             ),
                  //             Text(getLang(context, "Donor"))
                  //           ],
                  //         ))),
                  NavigationDestination(
                    icon: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(Icons.monetization_on_outlined),
                    ),
                    selectedIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: const Icon(Icons
                            .monetization_on) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    label: getLang(context, "Reward"),
                  ),
                  NavigationDestination(
                    //selectedIcon: Image.asset("icons/icon-profile-circle.png"),
                    icon: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(Icons.person_outline),
                    ),
                    selectedIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: const Icon(Icons
                            .person) //Image.asset(AppImages.boxIcon,scale: 6),
                    ),
                    label: getLang(context, "Profile"),

                  ),
                ],
              ),
            ),
          ),
        ),
        body: <Widget>[
          Home(),
          BranchMap(),
          // Center(
          //   child: Text("Akrem"),
          // ),
          Reword(),
          //Fund(),
          ProfileScreen(),
        ][currentPageIndex],
      ),
    );
  }
}
