import 'package:akrem/Api/user_api.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:akrem/Screens/login/register_page.dart';
import 'package:akrem/Screens/map/Select_location.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/user.dart';
import 'package:akrem/widgets/scrollable_column.dart';
import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  final _forgetEmailController = TextEditingController();

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
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.3), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: mediaSize.height / 5),
            child: _buildBottom(),
          ),
          Positioned(top: mediaSize.height / 11, child: _buildTop()),
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
          SizedBox(height: 100, width: 180, child: Image.asset(AppImages.akrem)

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
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: SizedBox(
          width: mediaSize.width,
          child: Card(
            color: Get.theme.colorScheme.onSurface,
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
        ));
  }

  Widget _buildForm() {
    return ScrollableColumn(
      children: [
        Container(
          height: 620,
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
                        //color: myColor,
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
                          // Checkbox(
                          //     value: rememberUser,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         rememberUser = value!;
                          //       });
                          //     }),
                          // const Text(
                          //   "Remember me",
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              UserAPI.resetPassword(
                                                  _forgetEmailController.text);
                                              Get.back();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  "Close"))
                                                        ],
                                                        title: const Text(
                                                            "Good work"),
                                                        content: Text(
                                                            "Mail has been send to you if your email is valued"),
                                                      ));
                                            },
                                            child: const Text("send")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("Close"))
                                      ],
                                      title: const Text("Forgot your password"),
                                      content: Container(
                                        height: 100,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                          Text("Enter your email"),
                                          SizedBox(height: 12),
                                          CustomInputField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            hintText: "Email",
                                            controller: _forgetEmailController,
                                            validator: Validator.validateEmail,
                                            label: "Email",
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  320),
                                            ],
                                          ),
                                        ]),
                                      )));
                        },
                        child: Text(
                          "I forgot my password", style: TextStyle(color: AppColors.positives),
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

              try {
                final respond = await UserAPI.getUser(
                    _emailController.text, _passwordController.text);

                if (respond["statusCode"] == 200) {
                  final UserApiModel userRespond = respond["user"];

                  final user =
                      await UserAPI.getUserInfo(userRespond.content?.token);

                  //List<String> role = user["role"];

                  // if (role.first != "Client") {
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //             actions: [
                  //               TextButton(
                  //                   onPressed: () {
                  //                     Get.back();
                  //                   },
                  //                   child: const Text("Close"))
                  //             ],
                  //             title: const Text("Data not valued"),
                  //             content: Text("This app only for Clients"),
                  //           ));
                  // }
                  await userController.newUser(User(
                      img: user["img"],
                      fName: user["fName"],
                      lName: user["LName"],
                      email: user["email"],
                      whatsapp: user["whatsApp"],
                      phone: user["phoneNumber"],
                      token: userRespond.content?.token));

                  Get.offAll(SelectLocation());
                } else if (respond["statusCode"] == 403) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Close"))
                            ],
                            title: const Text("activate your account"),
                            content: Text(
                                "Please check your email for an activation message from us"),
                          ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Close"))
                            ],
                            title: const Text("User not valued"),
                            content: Text(respond["user"].error ??
                                "Please try again using different email or password"),
                          ));
                  return;
                }
              } catch (e) {
                printError(
                    info:
                        "Error when requesting data from the server for login");
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Close"))
                          ],
                          title: const Text("Server not responding"),
                          content:
                              Text("Server not responding try again later"),
                        ));
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
                onPressed: () async {
                  // print("token val :${(userController.user).token}");
                  // print(
                  //     "locationString val :${(userController.user).locationString}");
                  //
                  await userController.newUser(User(
                      img:
                          "https://res.cloudinary.com/drmmayia1/image/upload/v1697917708/SmartMedicinePlatform/yyvplvxqd2vciyzppcsg.png",
                      fName: "Temp",
                      lName: "name",
                      email: "email@gmail.com",
                      whatsapp: false,
                      phone: "9182361233",
                      token: "9837465kdjhfsd"));

                  print(" email val :${(userController.user).email}");

                  Get.off(() => SelectLocation());
                }),
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
