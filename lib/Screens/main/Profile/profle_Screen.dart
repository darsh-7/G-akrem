import 'dart:async';

import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/controller_mang.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/widgets/profle_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed:( )/* () => Get.back()*/, icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          // TextButton(
          //   child: Text("Set locale to English"),
          //   onPressed: () => Get.updateLocale(Locale("en")),
          // ),
          // TextButton(
          //   child: Text("Set locale to Arabic"),
          //   onPressed: () => Get.updateLocale(Locale("ar")),
          // ),
          IconButton(
              onPressed: () {
                // const fiveSec = const Duration(seconds: 2);
                // new Timer.periodic(fiveSec, (Timer T) {
                // });
                // Get.updateLocale(Get.deviceLocale == Locale("en")
                //     ? Locale("ar")
                //     : Locale("en"));
                Get.updateLocale(
                  Locale('ar', "EG"), // Arabic
                );

                setState(() {});
                //Get.offAll(NavigationBarApp());
                // print("change theme");
              },
              icon: Icon(Get.locale == Locale('en')
                  ? Icons.maps_home_work
                  : Icons.outbond_outlined)),
          IconButton(
              onPressed: () {
                // const fiveSec = const Duration(seconds: 2);
                // new Timer.periodic(fiveSec, (Timer T) {
                // });
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                setState(() {});
                //Get.offAll(NavigationBarApp());
                // print("change theme");
              },
              icon: Icon(Get.isDarkMode ? Icons.nightlight : Icons.sunny))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80, right: 5, left: 5, top: 0),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            /// -- IMAGE
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage(AppImages.profileIcon))),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.mainColor),
                    child: const Icon(
                      Icons.ac_unit,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text("Zendaya", style: Theme.of(context).textTheme.headline4),
            Text("Zendaya@gmail.com",
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 20),

            /// -- BUTTON
            SizedBox(
              height: 48,
              width: 200,
              child: ElevatedButton(
                //onPressed: () => Get.to(() => const UpdateProfileScreen()),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text("EditProfile",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            /// -- MENU
            ProfileMenuWidget(
                title: "Settings", icon: Icons.settings, onPress: () {}),
            ProfileMenuWidget(
                title: "Donation History", icon: Icons.history, onPress: () {}),
            ProfileMenuWidget(
                title: "Billing Details", icon: Icons.wallet, onPress: () {}),
            // ProfileMenuWidget(title: "User Management", icon: Icons.verified_user, onPress: () {}),
            ProfileMenuWidget(
                title: "Support", icon: Icons.support_agent, onPress: () {}),

            const Divider(),
            const SizedBox(height: 10),
            ProfileMenuWidget(
                title: "About US", icon: Icons.info, onPress: () {}),

            ProfileMenuWidget(
                title: "Logout",
                icon: Icons.output_rounded,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "LOGOUT",
                    titleStyle: const TextStyle(fontSize: 20),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Are you sure, you want to Logout?"),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        userController.clearUser();
                        Get.offAll(const LoginPage());
                        // todo : remove all temp data and local storage
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: BorderSide.none),
                      child: const Text("Yes"),
                    ),
                    cancel: OutlinedButton(
                        onPressed: () => Get.back(), child: const Text("No")),
                  );
                }),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const SizedBox(
                height: 20,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Developed by ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Get.theme.shadowColor),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Ｍ𝕒ᐯ𝕖尺𝕚𝕔K𝕤",
                                  style: TextStyle(color: AppColors.mainColor)),
                              TextSpan(
                                text: " Team",
                                //style: TextStyle(color: Colors.red)
                              ),
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 2 / 2,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Image.asset(AppImages.mvrk),
                          ),
                        ),
                      ]),
                )
              ]),
            ]),
          ]),

          //   ],
          // ),
        ),
      ),
    );
  }
}
