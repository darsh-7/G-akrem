import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/constants/app_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.topCenter,
                  height: size.height * 0.38,
                  width: double.maxFinite,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          image: const DecorationImage(
                            image: AssetImage(
                              AppImages.emptyList,
                            ),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(15)),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                iconSize: 20,
                                icon: const Icon(Icons.info),
                              ),
                              IconButton(
                                iconSize: 20,
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.health_and_safety_outlined),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Image.asset(
                //   AppImages.emptyList,
                // ),
                const SizedBox(height: 40),
                Text(
                  "${getLang(context, "welcome")}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Donate your Medic to people who needed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "The easiest way to donate your medic\nwith us Akrem,\njoin NOW",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(const RegisterPage());
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8.0,
                        ),
                      ),

                      child: Text("${getLang(context, "Get Started")}"),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color(0xFFb8b8b8),
                      ),
                    ),
                    TextButton(
                      child: const Text("Login"),
                      onPressed: () => {
                        Get.offAll(const LoginPage()),
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

    );
  }
}
