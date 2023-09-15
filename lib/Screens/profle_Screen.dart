import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/widgets/profle_menu.dart';
import 'package:flutter/material.dart';
Color tPrimaryColor = AppColors.mainColor;
Color tDarkColor = AppColors.backGroundBar;

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
       // leading: IconButton(onPressed:( )/* () => Get.back()*/, icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text("Profile", style: Theme.of(context).textTheme.headline4 ),
        actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? Icons.sunny : Icons.nightlight))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage(AppImages.profileIcon))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
                      child: const Icon(Icons.ac_unit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Zenda", style: Theme.of(context).textTheme.headline4),
              Text("Zenda@gmail.com", style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  //onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("EditProfile", style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: Icons.settings, onPress: () {}),
              // ProfileMenuWidget(title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              // ProfileMenuWidget(title: "User Management", icon: Icons.verified_user, onPress: () {}),
              // const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.output_rounded,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    // Get.defaultDialog(
                    //   title: "LOGOUT",
                    //   titleStyle: const TextStyle(fontSize: 20),
                    //   content: const Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 15.0),
                    //     child: Text("Are you sure, you want to Logout?"),
                    //   ),
                    //   confirm: Expanded(
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //       },
                    //       style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                    //       child: const Text("Yes"),
                    //     ),
                    //   ),
                    //   cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                    // );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}