import 'package:akrem/Api/user_api.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/map/map_screen.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/controller_mang.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/user.dart';
import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../main/NavigationBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage() : super();

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  // UserController get userController  => ControllerManager.userController;
  // User get user  => ControllerManager.userController.user;

  UserController userController = Get.find();

  @override
  void initState() {
    print(" token val :${(userController.user).token}");
    print("locationString val :${(userController.user).locationString}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: const AssetImage("assets/medicBackground.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(
            bottom: 0,
            child: _buildBottom(),
          ),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 100,
              width: 180,
              child: Image.asset(AppImages.akrem)
              
              // SvgPicture.asset(
              //   AppImages.akremSVG,
              //   fit: BoxFit.scaleDown,
              // )
          ),
          // Icon(
          //   Icons.health_and_safety_outlined,
          //   size: 50,
          //   color: Colors.white,
          // ),
          // Text(
          //   "Akrem",
          //   style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontFamily: "front",
          //       fontSize: 40,
          //       letterSpacing: 2),
          // )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Get.theme.colorScheme.onBackground,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 572,
          width: double.infinity,
          color: Colors.transparent,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: myColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w500),
                  ),
                  _buildGreyText("Please login with your information"),
                  const SizedBox(height: 20),
                  CustomInputField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    controller: _emailController,
                    validator: Validator.validateEmail,
                    label: "Email",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(320),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomInputField(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Password",
                    obscureText: true,
                    controller: _passwordController,
                    validator: Validator.validatePassword,
                    label: "Password",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: rememberUser,
                              onChanged: (value) {
                                setState(() {
                                  rememberUser = value!;
                                });
                              }),
                          const Text(
                            "Remember me",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "I forgot my password",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 8),
              _buildOtherLogin(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() == false) return;

              var respond = await UserAPI.getUser(
                  _emailController.text,
                  _passwordController.text);


              if (respond["statusCode"]==200) {





                Get.offAll(NavigationBarApp());
              } else{
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Close"))
                      ],
                      title: const Text("Data not valued"),
                      content: const Text(
                          "Please try again using different email or password"),
                    ));
                return;
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              elevation: 20,
              shadowColor: Colors.grey.shade700,
              minimumSize: const Size.fromHeight(48),
              backgroundColor: myColor,
            ),
            child: const Text("LOGIN"),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 28,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: RawMaterialButton(
              shape: const StadiumBorder(),
              child: const Text(
                "Fake Login",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              onPressed: () {
                print("token val :${(userController.user).token}");
                print("locationString val :${(userController.user).locationString}");

                userController.editUser(User(fName: "Mostafa",token: "kajshdkashjd"));
                Get.off(() => SelectLocation());

              }
            ),
          ),
          Container(
            //margin: const EdgeInsets.all(20),
            height: 28,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: RawMaterialButton(
              shape: const StadiumBorder(),
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              onPressed: () => Get.offAll(SelectLocation()),
            ),
          ),

          _buildGreyText("Or Login with"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                  icon: Image.asset(
                "assets/socialIcons/google.png",
                width: 32,
                height: 32,
              )),
              Tab(
                  icon: Image.asset(
                "assets/socialIcons/facebook.png",
                width: 32,
                height: 32,
              )),
              Tab(
                icon: Icon(
                  Icons.apple,
                  color: Colors.grey,
                  size: 35,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Don't have an account",
                style: TextStyle(
                  color: Color(0xFFb8b8b8),
                ),
              ),
              TextButton(
                child: const Text("Register"),
                onPressed: () => Get.offAll(RegisterPage()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
