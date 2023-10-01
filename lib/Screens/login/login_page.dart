import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/medicBackground.png"),
          fit: BoxFit.cover,
          colorFilter:
          ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.health_and_safety_outlined,
            size: 50,
            color: Colors.white,
          ),
          Text(
            "Akrem",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4,right: 8,left: 8),
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
          child:         ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
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

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == false) return;

              // if (_emailController.text == "admin@gmail.com" &&
              //     _passwordController.text == "admin") {
              //   showDialog(
              //       context: context,
              //       builder: (context) => AlertDialog(
              //             actions: [
              //               TextButton(
              //                   onPressed: () {
              //                     Navigator.of(context).pop();
              //                   },
              //                   child: const Text("Close"))
              //             ],
              //             title: const Text("Data not valued"),
              //             content: const Text(
              //                 "Pls try again using different email or password"),
              //           ));
              //   return;
              // }

              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/main', (Route<dynamic> route) => false);
              });
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              elevation: 20,
              shadowColor: Colors.grey,
              minimumSize: const Size.fromHeight(48),
              backgroundColor: myColor,
            ),
            child: const Text("LOGIN"),
          ),
          Container(
            margin: const EdgeInsets.all(20),
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
                  style: TextStyle(fontSize: 20,color: Colors.grey),
                ),
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/main', (Route<dynamic> route) => false);
                  });
                }),
          ),
          _buildGreyText("Or Login with"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/socialIcons/google.png",width: 32,height: 32,)),
              Tab(icon: Image.asset("assets/socialIcons/facebook.png",width: 32,height: 32,)),
              Tab(icon: Image.asset("assets/socialIcons/github.png",width: 32,height: 32,)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Don't have an account",
                style: TextStyle(
                  color: AppColors.mainColor,
                ),
              ),
              TextButton(
                child: const Text("Register"),
                onPressed: () =>
                {Navigator.of(context).pushNamed("/register")},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
