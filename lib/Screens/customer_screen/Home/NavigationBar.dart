import 'dart:ui';

import 'package:akrem/Screens/customer_screen/Home/basket_page.dart';
import 'package:akrem/Screens/main/Fund.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Screens/main/home_screen.dart';
import 'package:akrem/Screens/main/Profile/profle_Screen.dart';
import 'package:akrem/Screens/main/show_branchs.dart';
import 'package:akrem/Screens/map/branchs_map.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// void main() => runApp(const NavigationBarApp());

class CustomerNavigationBar extends StatefulWidget {
  CustomerNavigationBar({
    super.key,
  });

  @override
  State<CustomerNavigationBar> createState() => _NavigationBarApp();
}

UserController userController = Get.find();

var profileImg = NetworkImage(userController.user.img ??
    "https://res.cloudinary.com/drmmayia1/image/upload/v1697917708/SmartMedicinePlatform/yyvplvxqd2vciyzppcsg.png");

class _NavigationBarApp extends State<CustomerNavigationBar> {
  int currentPageIndex = 0;
  Image image = Image.asset(
    AppImages.profileIcon,
  );
  var radius = const Radius.circular(10);

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.blue, // status bar color
    ));
    final ShoppingCardController shoppingCardController = Get.put(ShoppingCardController());

    super.initState();
  }

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
                height: 4 * 15,
                //surfaceTintColor: Colors.red,
                //shadowColor: Colors.red,
                //backgroundColor: Get.theme.navigationBarTheme.backgroundColor,

                backgroundColor:
                    Get.theme.colorScheme.background.withAlpha(150),
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
                            .shopping_basket) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .shopping_basket) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    label: 'basket',
                  ),
                  NavigationDestination(
                    selectedIcon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .location_on_rounded) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .location_on_rounded) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    label: 'Hub',
                  ),
                  InkWell(
                      onTap: () {
                        Get.offAll(NavigationBarApp());
                      },
                      child: Container(
                          // width: 40,
                          // height: MediaQuery.of(context).padding.bottom + 200,
                          decoration: BoxDecoration(
                              // color: Get.theme.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                //padding: EdgeInsets.all(4),
                                child: SvgPicture.asset(
                                  AppImages.akremLogoSVG,
                                  colorFilter: ColorFilter.mode(
                                      Get.theme.shadowColor, BlendMode.srcIn),
                                ),
                              ),
                              Text("Consumer")
                            ],
                          ))),
                  NavigationDestination(
                    selectedIcon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .crisis_alert) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    icon: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          // color: AppColors.mainColor,
                        ),
                        child: const Icon(Icons
                            .crisis_alert) //Image.asset(AppImages.boxIcon,scale: 6),
                        ),
                    label: 'Delivery',
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
                          child: ClipOval(
                            child: FadeInImage(
                              image: profileImg,
                              placeholder: const AssetImage(AppImages.noImage),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(AppImages.noImage,
                                    fit: BoxFit.fitWidth);
                              },
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),

                    icon: Container(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(4), // Border radius
                          child: ClipOval(
                            child: FadeInImage(
                              image: profileImg,
                              placeholder: const AssetImage(AppImages.noImage),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(AppImages.noImage,
                                    fit: BoxFit.fitWidth);
                              },
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
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
          BasketPage(),
          BranchMap(),
          Center(
            child: Text("Akrem"),
          ),
          Center(
            child: Text("Akrem"),
          ),
          ProfileScreen(),
        ][currentPageIndex],
      ),
    );
  }
}
