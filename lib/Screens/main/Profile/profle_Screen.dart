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
        title: Text("Profile", style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(
              onPressed: () {
              //  Get.changeTheme();
              },
              icon: Icon(isDark ? Icons.sunny : Icons.nightlight))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80 ,right: 5,left: 5,top: 0),
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
            ProfileMenuWidget(title: "Donation History", icon: Icons.history, onPress: () {}),
            ProfileMenuWidget(title: "Billing Details", icon: Icons.wallet, onPress: () {}),
            // ProfileMenuWidget(title: "User Management", icon: Icons.verified_user, onPress: () {}),
            ProfileMenuWidget(title: "Support", icon: Icons.support_agent, onPress: () {}),

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
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  child: const SizedBox(
                height: 20,
              )),
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
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Ｍ𝕒ᐯ𝕖尺𝕚𝕔K𝕤",
                                  style: TextStyle(color: AppColors.mainColor)),
                              const TextSpan(
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
